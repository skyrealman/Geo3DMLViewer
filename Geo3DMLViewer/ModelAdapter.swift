//
//  ModelAdapter.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/9/20.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa

class ModelAdapter{
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
    
    func modelDirectoryPath() -> String{
        return url.deletingLastPathComponent().absoluteString
    }
    
    
    func parserDidStartDocument(_ parser: XMLParser) {
        Logger.instance.debug(items: "开始解析XML")
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        Logger.instance.debug(items: "XML解析完毕")
    }

    
    func modelFileCode(){
        do{
            let _ = try String(contentsOf: url, encoding: String.Encoding.utf8)

        }catch _ as NSError{
            Logger.instance.warning(items: "模型文件不是utf8格式")
        }
    }
    
    func modelFileList() -> [String]?{
        var fileList = [String]()
        Logger.instance.info(items: filePath)
        guard
            let data = try? Data(contentsOf: url)
        else {return nil}
        
        do {
            let xmlDoc = try DOMXMLDocument(xml: data)
            print(xmlDoc.xml)
            //Logger.instance.info(items: xmlDoc.root.children[3].children[0].children[0].attributes["href"])
            //Logger.instance.info(items: xmlDoc.root["Maps"]["Map"].children[0].attributes["href"])
            guard xmlDoc.root["Maps"]["Map"].children.count != 0 && xmlDoc.root["Models"]["Model"].children.count != 0
            else {return nil}
            let model_count = xmlDoc.root["Maps"].children.count
            let map_count = xmlDoc.root["Models"].children.count
            if(model_count != map_count){
                Logger.instance.warning(items: "模型的数据集数与图层集数不相等")
            }
            for i in 0 ..< model_count{
                let file = (xmlDoc.root["Maps"].children[i])["xi:include"].attributes["href"]
                if let file = file{
                    fileList.append(file)
                    Logger.instance.info(items: file)
                }
                
            }
            for i in 0 ..< map_count{
                let file = (xmlDoc.root["Models"].children[i])["xi:include"].attributes["href"]
                if let file = file{
                    fileList.append(file)
                    Logger.instance.info(items: file)
                }
            }
   
        } catch {
            Logger.instance.error(items: "\(error)")
        }
        return fileList
    }
}
