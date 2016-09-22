//
//  ModelAdapter.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/9/20.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa

class ModelAdapter: NSObject, XMLParserDelegate{
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
    func parseProjFile() -> [String]?{
        var allModelFile: [String]?
        let parser = XMLParser(contentsOf: URL(fileURLWithPath: filePath))
        parser?.delegate = self
        parser?.parse()
        return allModelFile
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if (elementName as NSString).isEqual(to: "geo3dml:Name"){
            print(attributeDict)
        }
    }
    func parserDidStartDocument(_ parser: XMLParser) {
        Logger.instance.debug(items: "开始解析XML")
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        Logger.instance.debug(items: "XML解析完毕")
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
    }
    func generateDictArray(){
        let parser = XMLParser(contentsOf: url)
        parser?.delegate = self
        parser?.parse()
        
    }
    func checkXMLWithDict(dictFile: URL){
        
    }
    
    func checkFileCode(){
        do{
            let _ = try String(contentsOf: url, encoding: String.Encoding.utf8)

        }catch _ as NSError{
            Logger.instance.warning(items: "模型文件不是utf8格式")
        }
    }
    
}
