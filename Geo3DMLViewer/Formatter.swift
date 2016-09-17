//
//  Formatter.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/17.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa
public enum Component {
    case Date(String)
    case Level
    case Message
}

public class Formatters {}
public class Formatter: Formatters{
    
    private var format: String
    
    private var components: [Component]
    
    let dateFormatter = DateFormatter()
    
    internal weak var logger: Logger!
    
    internal var description: String{
        return String(format: format, arguments: components.map{(component: Component) -> CVarArg in
            return String(describing: component).uppercased()
        })
    }
    
    public convenience init(_ format: String, _ components: Component...){
        self.init(format, components)
    }
    public init(_ format: String, _ components: [Component]){
        self.format = format
        self.components = components
    }
    
    func format(date: Date, level: Level, items: [Any], separator: String, terminator: String) -> String{
        let arguments = components.map{ (component: Component) -> CVarArg in
            switch component{
            case .Date(let dateFormat):
                return format(date: date, dateFormat: dateFormat)
            case .Level:
                return format(level: level)
            case .Message:
                return items.map({String(describing: $0)}).joined(separator: separator)
            }

        }
        return String(format: format, arguments: arguments) + terminator
    }
}
public extension Formatter{
    func format(date: Date, dateFormat: String) -> String{
         dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    func format(level: Level) -> String{
        let text = level.description
        return text.withColor(color: "#333333")
    }
}
