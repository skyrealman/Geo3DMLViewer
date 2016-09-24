//
//  ModelChecker.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/9/20.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa

class BaseFileChecker{
    let filePath: String
    let url: URL
    
    init(path: String){
        self.filePath = path
        url = URL(fileURLWithPath: filePath)
    }
    init(url: URL){
        self.url = url
        self.filePath = url.absoluteString
    }
    
    var xmlDoc: DOMXMLDocument?{
        guard
            let data = try? Data(contentsOf: url)
            else {return nil}
        do{
            let xmlDoc = try DOMXMLDocument(xml: data)
            return xmlDoc
        }catch{
            Logger.instance.error(items: "\(error)")
        }
        return nil
    }
    func fileCodeChecker(code: String){
        do{
            if(code == "utf8"){
                let _ = try String(contentsOf: url, encoding: String.Encoding.utf8)
            }
            
        }catch _ as NSError{
            Logger.instance.warning(items: "模型文件不是\(code)格式")
        }
    }
    func getFileType() -> String?{
        //print(xmlDoc?.root.name)
        if xmlDoc?.root.name == "Geo3DMap"{
            return "Geo3DMap"
        }else if xmlDoc?.root.name == "GeoModel"{
            return "GeoModel"
        }else if xmlDoc?.root.name == "Geo3DProject"{
            return "Geo3DProject"
        }
        else{
            Logger.instance.error(items: "未知的文件格式")
            return nil
        }
    }
    func getDictList() -> [String]?{
        var dictList = [String]()
        guard
        let dictFile = Bundle.main.path(forResource: "Dictionary", ofType: "xml", inDirectory: "resources"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: dictFile))
        else {
            Logger.instance.error(items: "找不到检验所需的字典文件")
            return nil}
        do{
            let xmlDoc = try DOMXMLDocument(xml: data)
            xmlDoc.root.getAllLeaves(leaves: &dictList)
            for t in dictList{
                print(t)
            }
            return dictList
        }catch{
            Logger.instance.error(items: "\(error)")
        }
        return nil
    }
    
    func fileSyntaxChecker(){
        
    }
}

class ProjFileChecker: BaseFileChecker{
    
    func isProjFile() -> Bool{
        return false
    }
    
    fileprivate func directoryPath() -> String{
        return url.deletingLastPathComponent().path
    }
    func getFilePath() -> [String]?{
        var filePath = [String]()
        let fileList = self.getFileList()
        if let fileList = fileList{
            filePath = fileList.map{
                self.directoryPath() + "/" + $0
            }
        }
        return filePath
    }
    func checkFileExists() -> [String]?{
        guard let  FileList = self.getFileList() else{
            return nil
        }
        var existFileList: [String]?
        let fileManager = FileManager.default
        for file in FileList{
            
            if fileManager.fileExists(atPath: self.directoryPath() + "/" + file){
                existFileList?.append(file)
            }else{
                Logger.instance.error(items: "模型关联文件\(file)不存在")
            }
        }
        return existFileList
    }
    
     fileprivate func getFileList() -> [String]?{
        var fileList = [String]()
        
        guard xmlDoc?.root["Maps"]["Map"].children.count != 0 && xmlDoc?.root["Models"]["Model"].children.count != 0
            else {return nil}
        let model_count = xmlDoc?.root["Maps"].children.count
        let map_count = xmlDoc?.root["Models"].children.count
        if(model_count != map_count){
            Logger.instance.warning(items: "模型的数据集数与图层集数不相等")
        }
        if let model_count = model_count , let map_count = map_count {
            for i in 0 ..< model_count{
                let file = (xmlDoc?.root["Maps"].children[i])?["xi:include"].attributes["href"]
                if let file = file{
                    fileList.append(file)
                    Logger.instance.info(items: file)
                }
                
            }
            for i in 0 ..< map_count{
                let file = (xmlDoc?.root["Models"].children[i])?["xi:include"].attributes["href"]
                if let file = file{
                    fileList.append(file)
                    Logger.instance.info(items: file)
                }
            }
        }
        
        
        return fileList
    }
}

class MapFileChecker: BaseFileChecker{

    override func fileSyntaxChecker() {
        let dictList = getDictList()
        
        var syntaxList = [String]()
        xmlDoc?.root.getAllLeaves(leaves: &syntaxList)
        
        for syntax in syntaxList{
            if !(dictList?.contains(syntax))!{
                Logger.instance.warning(items: "文件\(url.lastPathComponent)存在未知标签 \"\(syntax)\"")
            }
        }
    }
}

class ModelFileChecker: BaseFileChecker{

    override func fileSyntaxChecker() {
        
    }
}

