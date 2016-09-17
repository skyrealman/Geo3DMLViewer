//
//  Logger.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/16.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation
public enum Level{
    case Trace, Debug, Info, Warning, Error
    
    var description: String{
        return String(describing: self).uppercased()
    }
}

extension Level: Comparable{}

public func ==(x: Level, y: Level) -> Bool{
    return x.hashValue == y.hashValue
}

public func <(x: Level, y: Level) -> Bool{
    return x.hashValue < y.hashValue
}

open class Logger{
    public var enabled: Bool = true
    
    
}
