//
//  ModelAdapter.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/9/20.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa

class ModelAdapter: NSObject, XMLParserDelegate{
    var fileURL: String

    init(url: String){
        self.fileURL = url
        let  url: URL = URL(fileURLWithPath: fileURL)
        
    }
    func getAllModelFile() -> [String]?{
        var allModelFile: [String]?
        let parser = XMLParser(contentsOf: URL(fileURLWithPath: fileURL))
        parser?.delegate = self
        parser?.parse()
        return allModelFile
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
    }
    func parserDidStartDocument(_ parser: XMLParser) {
        Logger.instance.debug(items: "开始解析XML")
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        Logger.instance.debug(items: "XML解析完毕")
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
    }
    
    func checkXMLWithSchema(){
        
    }
    
    func checkFileCode(){
        
    }
}
