//
//  Geo3DModel.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/8/30.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation

struct Geo3DModel {
    var name: String
    var type: String
    var metadata: Geo3DModelMetadata
    var featureClasses: [GeoFeatureClassType]
    var featureRelationship: [GeoFeatureRelationType]
    
    init(name: String, type: String, metadata: Geo3DModelMetadata, featureClasses: [GeoFeatureClassType], featureRelationship: [GeoFeatureRelationType]){
        self.name = name
        self.type = type
        self.metadata = metadata
        self.featureClasses = featureClasses
        self.featureRelationship = featureRelationship
    }
}