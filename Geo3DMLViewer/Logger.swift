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

open class Logger: NSObject{
    
    static let instance: Logger = Logger()
    class func shareLogger() -> Logger{
        return instance
    }
    dynamic var logMessageArray: [String] = []
    
    public var enabled: Bool = true
    public var formatter: Formatter{
        didSet{ formatter.logger = self}
    }
    public var minLevel: Level
    public var format: String{
        return formatter.description
    }
    
    //private let queue = DispatchQueue(label: "geo.log")
    
    public init(formatter: Formatter = .Default, minLevel: Level = .Trace){
        
        self.formatter = formatter
        self.minLevel = minLevel
        super.init()
        formatter.logger = self
    }
    public func trace(items: Any..., separator: String = " ", terminator: String = "\n"){
        log(.Trace, items, separator, terminator)
    }
    public func debug(items: Any..., separator: String = " ", terminator: String = "\n"){
        log(.Debug, items, separator, terminator)
    }
    public func info(items: Any..., separator: String = " ", terminator: String = "\n"){
        log(.Info, items, separator, terminator)
    }
    public func warning(items: Any..., separator: String = " ", terminator: String = "\n"){
        log(.Warning, items, separator, terminator)
    }
    public func error(items: Any..., separator: String = " ", terminator: String = "\n"){
        log(.Error, items, separator, terminator)
    }
    
    private func log(_ level: Level, _ items: [Any], _ separator: String, _ terminator: String){
        guard enabled && level >= minLevel else{ return }
        
        let date = Date()
        let result = formatter.format(date: date, level: level, items: items, separator: separator, terminator: terminator)
        self.logMessageArray.append(result)

        //queue.async {}
    }
    
}
