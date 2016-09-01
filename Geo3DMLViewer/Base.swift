//
//  Base.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/9/1.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation
protocol BaseType{
    var annotation: String {get set}
}
protocol Geo3DProjectType: BaseType {
    var name: String {get set}
    var description: String {get set}
    var style: GeoSceneStylePropertyType {get set}
    var models: [Geo3DModelType] {get set}
    var maps: [Geo3DMapType] {get set}
}
protocol Geo3DModelType: BaseType{
    
}
protocol GeoSceneStylePropertyType: BaseType{
    
}