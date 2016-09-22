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
    
    
    
    func parserDidStartDocument(_ parser: XMLParser) {
        Logger.instance.debug(items: "开始解析XML")
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        Logger.instance.debug(items: "XML解析完毕")
    }

    
    func checkFileCode(){
        do{
            let _ = try String(contentsOf: url, encoding: String.Encoding.utf8)

        }catch _ as NSError{
            Logger.instance.warning(items: "模型文件不是utf8格式")
        }
    }
    
    func getFileList() -> [String]?{
        let fileList = [String]()
        Logger.instance.info(items: filePath)
        guard
            let data = try? Data(contentsOf: url)
        else {return nil}
        
        do {
            let xmlDoc = try DOMXMLDocument(xml: data)
            print(xmlDoc.xml)
            Logger.instance.info(items: xmlDoc.root.children[3].children[0].children[0].attributes["href"])
            Logger.instance.info(items: xmlDoc.root["Maps"]["Map"].children[0].attributes["href"])
            guard xmlDoc.root["Geo3DProject"]["Maps"].children.count != 0 && xmlDoc.root["Geo3DProject"]["Models"].children.count != 0
            else {return nil}
            let files = xmlDoc.root["Geo3DProject"]["Maps"]["Map"]["xi:include"].attributes["href"]
            Logger.instance.info(items: files)
   
        } catch {
            Logger.instance.error(items: "\(error)")
        }
        return fileList
    }
}
