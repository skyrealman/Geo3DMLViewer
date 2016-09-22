//
//  Document.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/22.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation

open class DOMXMLDocument: DOMXMLElement{
    
    open var root: DOMXMLElement{
        guard let rootElement = children.first else{
            let errorElment = DOMXMLElement(name: "Error")
            errorElment.error = DOMXMLError.rootElementMissing
            return errorElment
        }
        return rootElement
    }
    
    open let options: DOMXMLOptions
    
    public init(root: DOMXMLElement? = nil, options: DOMXMLOptions = DOMXMLOptions()){
        self.options = options
        
        let documentName = String(describing: DOMXMLDocument.self)
        super.init(name: documentName)
        
        parent = nil
        
        if let rootElement = root{
            _ = addChild(rootElement)
        }
    }
    
    public convenience init(xml: Data, options: DOMXMLOptions = DOMXMLOptions()) throws {
        self.init(options: options)
        try loadXML(xml)
    }
    
    public convenience init(xml: String, encoding: String.Encoding = String.Encoding.utf8, options: DOMXMLOptions = DOMXMLOptions()) throws{
        guard let data = xml.data(using: encoding) else { throw DOMXMLError.parsingFailed }
        try self.init(xml: data, options: options)
    }
    
    open func loadXML(_ data: Data) throws{
        children.removeAll(keepingCapacity: false)
        let xmlParser = DOMXMLParser(document: self, data: data)
        try xmlParser.parse()
    }
    
    open override var xml: String{
        var xml = "\(options.documentHeader.xmlString)\n"
        for child in children{
            xml += child.xml
        }
        return xml
    }
}
