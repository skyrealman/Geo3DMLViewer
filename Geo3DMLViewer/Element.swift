//
//  Element.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/22.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation

open class DOMXMLElement{
    
    open internal(set) weak var parent: DOMXMLElement?
    
    open internal(set) var children = [DOMXMLElement]()
    
    open var name: String
    
    open var value: String?
    
    open var attributes: [String: String]
    
    open var error: DOMXMLError?
    
    open var string: String { return value ?? String()}
    
    open var bool: Bool {return string.lowercased() == "true" || Int(string) == 1 ? true : false }
    
    open var int: Int {return Int(string) ?? 0}
    
    open var double: Double {return Double(string) ?? 0.00 }
    
    public init(name: String, value: String? = nil, attributes: [String: String] = [String : String]()){
        self.name = name
        self.value = value
        self.attributes = attributes
    }
    
    open subscript(key: String) -> DOMXMLElement{
        guard let
            first = children.filter({$0.name == key}).first
        else {
            let errorElement = DOMXMLElement(name: key)
            errorElement.error = DOMXMLError.elementNotFound
            return errorElement
        }
        return first
    }
    
    open var all: [DOMXMLElement]? {return parent?.children.filter{ $0.name == self.name} }
    
    open var first: DOMXMLElement? {return all?.first}
    
    open var last: DOMXMLElement? {return all?.last}
    
    open var count: Int {return all?.count ?? 0}
    
    fileprivate func filter(withCondition condition: (DOMXMLElement) -> Bool) -> [DOMXMLElement]?{
        guard let elements = all else { return nil }
        var found = [DOMXMLElement]()
        for element in elements{
            if condition(element){
                found.append(element)
            }
        }
        return found.count > 0 ? found : nil
    }
    
    open func all(withValue value: String) -> [DOMXMLElement]?{
        let found = filter{(element) -> Bool in
            return element.value == value
        }
        return found
    }
    
    @discardableResult open func addChild(_ child: DOMXMLElement) -> DOMXMLElement{
        child.parent = self
        children.append(child)
        return child
    }
    
    @discardableResult open func addChild(name: String, value: String? = nil, attributes: [String: String] = [String: String]()) -> DOMXMLElement{
        let child = DOMXMLElement(name: name, value: value, attributes: attributes)
        return addChild(child)
    }
    
    fileprivate func removeChild(_ child: DOMXMLElement){
        if let childIndex = children.index(where: {$0 === child}){
            children.remove(at:childIndex)
        }
    }
    
    open func removeFromParent(){
        parent?.removeChild(self)
    }
    
    fileprivate var parentsCount: Int{
        var count = 0
        var element = self
        while let parent = element.parent{
            count += 1
            element = parent
        }
        return count
    }
    
    fileprivate func indent(withDepth depth: Int) -> String{
        var count = depth
        var indent = String()
        
        while count > 0{
            indent += "\t"
            count -= 1
        }
        return indent
    }
    
    open var xml: String{
        var xml = String()
        
        xml += indent(withDepth: parentsCount - 1)
        xml += "<\(name)"
        
        if attributes.count > 0{
            for(key, value) in attributes {
                xml += " \(key)=\"\(value.xmlEscaped)\""
            }
        }
        if value == nil && children.count == 0{
            xml += " />"
        }else{
            if children.count > 0 {
                xml += ">\n"
                for child in self.children{
                    xml += "\(child.xml)\n"
                }
                xml += indent(withDepth: parentsCount - 1)
                xml += "</\(name)>"
            }else{
                xml += ">\(string.xmlEscaped)</\(name)>"
            }
        }
        return xml
    }
    
    open var xmlCompact: String{
        let chars = CharacterSet(charactersIn: "\n\t")
        return xml.components(separatedBy: chars).joined(separator: "")
    }
}

public extension String {
    
    public var xmlEscaped: String {

        var escaped = replacingOccurrences(of: "&", with: "&amp;", options: .literal)
        
        let escapeChars = ["<" : "&lt;", ">" : "&gt;", "'" : "&apos;", "\"" : "&quot;"]
        for (char, echar) in escapeChars {
            escaped = escaped.replacingOccurrences(of: char, with: echar, options: .literal)
        }
        
        return escaped
    }
    
}
