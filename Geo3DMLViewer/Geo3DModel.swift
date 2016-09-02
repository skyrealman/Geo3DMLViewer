//
//  Geo3DModel.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/8/30.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation

protocol Geo3DModelType: BaseType{
    var name: String {get}
    var type: ModelType {get}
}

struct Geo3DModel: Geo3DModelType {
    var annotation: String = ""
    var name: String
    var type: ModelType
    var featureClass: [GeoFeatureClassType]
    var featureRelationship: [GeoFeatureRelationType]
    
    init(name: String, type: ModelType, featureClass: [GeoFeatureClassType], featureRelationship: [GeoFeatureRelationType]){
        self.name = name
        self.type = type
        self.featureClass = featureClass
        self.featureRelationship = featureRelationship
    }
}