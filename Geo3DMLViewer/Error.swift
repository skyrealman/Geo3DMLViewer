//
//  Error.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/22.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation

public enum DOMXMLError: Error{
    case elementNotFound
    
    case rootElementMissing
    
    case parsingFailed
}
