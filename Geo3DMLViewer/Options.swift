//
//  Options.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/22.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation

public struct DOMXMLOptions{
    
    public struct DocumentHeader{
        
        public var version = 1.0
        
        public var encoding = "utf-8"
        
        public var standalone = "no"
        
        public var xmlString: String{
            return "<?xml version=\"\(version)\" encoding=\"\(encoding)\" standalone=\"\(standalone)\"?>"
        }
    }
    
    public struct ParserSettings{
        
        public var shouldProcessNamespaces = false
        
        public var shouldReportNamespacePrefixes = false
        
        public var shouldResolveExternalEntities = false
        
    }
    
    public var documentHeader = DocumentHeader()
    
    public var parserSettings = ParserSettings()
    
    public init(){}
}
