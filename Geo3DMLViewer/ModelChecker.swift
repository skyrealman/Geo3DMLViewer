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
    func FileCodeChecker(code: String){
        do{
            if(code == "utf8"){
                let _ = try String(contentsOf: url, encoding: String.Encoding.utf8)
            }
            
        }catch _ as NSError{
            Logger.instance.warning(items: "模型文件不是\(code)格式")
        }
    }
    func FileSyntaxChecker(){
        
    }
}

class ProjFileChecker: BaseFileChecker{
    
    func isProjFile() -> Bool{
        return false
    }
    
    fileprivate func DirectoryPath() -> String{
        return url.deletingLastPathComponent().absoluteString
    }
    func checkFileExists() -> [String]?{
        guard let  FileList = self.getFileList() else{
            return nil
        }
        var existFileList: [String]?
        let fileManager = FileManager.default
        for file in FileList{
            if fileManager.fileExists(atPath: self.DirectoryPath() + file){
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
    func isMapFile() -> Bool{
        return false
    }
    override func FileSyntaxChecker() {
        
    }
}

class ModelFileChecker: BaseFileChecker{
    func isModelFile() -> Bool{
        return false
    }
    override func FileSyntaxChecker() {
        
    }
}

