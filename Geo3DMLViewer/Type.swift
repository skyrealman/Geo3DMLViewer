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
//地质模型相关
protocol Geo3DModelType: BaseType{
    var name: String {get set}
    var type: ModelType {get set}
    var metadata: GeoModelMetadataType {get set}
    var featureClasses: [GeoFeatureClassType] {get set}
    var featureRelationship: [GeoFeatureRelationType] {get set}
}
protocol GeoModelMetadataType: BaseType{
    
}

//地质图相关
protocol Geo3DMapType: BaseType{
    
}
//地质要素相关
protocol GeoFeatureType: BaseType, AbstractGML {
    var fields: Dictionary<String, String> {get set}
    var geometry: AbstractGeometry {get set}
    
}
protocol GeoFeatureRelationType: BaseType {
    
}

protocol GeologicHistoryType: BaseType {
    
}
protocol DefiningStructureType: BaseType {
    
}
protocol AggregationRelationType: BaseType {
    
}
protocol BoundaryRelationType: BaseType{
    
}
//地质要素类相关
protocol GeoFeatureClassType: BaseType, AbstractGML{
    var schema: Dictionary<String, String> {get set}
    var feature: [GeoFeatureType] {get set}
}
//style相关
protocol GeoSceneStylePropertyType: BaseType{
    
}
