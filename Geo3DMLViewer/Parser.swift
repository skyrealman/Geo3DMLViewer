//
//  Parser.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/22.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation

internal class DOMXMLParser: NSObject, XMLParserDelegate{
    
    let document: DOMXMLDocument
    
    let data: Data
    
    var currentParent: DOMXMLElement?
    
    var currentElement: DOMXMLElement?
    
    var currentValue = String()
    
    var parseError: Error?
    
    init(document: DOMXMLDocument, data: Data){
        self.document = document
        self.data = data
        currentParent = document
        
        super.init()
    }
    
    func parse() throws {
        let parser = XMLParser(data: data)
        parser.delegate = self
        
        parser.shouldProcessNamespaces = document.options.parserSettings.shouldProcessNamespaces
        parser.shouldReportNamespacePrefixes = document.options.parserSettings.shouldReportNamespacePrefixes
        parser.shouldResolveExternalEntities = document.options.parserSettings.shouldResolveExternalEntities
        
        let success = parser.parse()
        
        if !success {
            guard let error = parseError else { throw DOMXMLError.parsingFailed }
            throw error
        }
    }
    
    @objc func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentValue = String()
        currentElement = currentParent?.addChild(name: elementName, attributes: attributeDict)
        currentParent = currentElement
    }
    
    @objc func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue += string
        let newValue = currentValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        currentElement?.value = newValue == String() ? nil : newValue
    }
    
    @objc func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentParent = currentParent?.parent
        currentElement = nil
    }
    
    @objc func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        self.parseError = parseError
    }
}
