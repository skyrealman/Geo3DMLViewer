//
//  Utilities.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/17.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa

internal extension String{
    var lastPathComponent: String{
        return NSString(string: self).lastPathComponent
    }
    func withColor(color: String) -> String{
        return "\u{001b}[fg\(color);\(self)\u{001b}[;"
    }
}
