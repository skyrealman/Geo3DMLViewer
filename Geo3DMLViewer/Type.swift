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

protocol GeoModelMetadataType: BaseType{
    var description: String {get set}
    var toolName: String {get set}
    var toolVersion: String {get set}
    var spatialReferenceSystem: AbstractSpatialReferenceSystem {get set}
}

//地质图相关
protocol Geo3DMapType: BaseType{
    
}
//地质要素类相关

//style相关
protocol GeoSceneStylePropertyType: BaseType{
    
}
