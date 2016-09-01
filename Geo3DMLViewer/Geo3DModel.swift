//
//  Geo3DModel.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/8/30.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation

class Geo3DModel {
    var name: String
    var type: String
    var metadata: Geo3DModelMetadata
    var featureClasses: [GeoFeatureClass]
    var featureRelationship: [GeoFeatureRelation]
    
    init(name: String, type: String, metadata: Geo3DModelMetadata, featureClasses: [GeoFeatureClass], featureRelationship: [GeoFeatureRelation]){
        self.name = name
        self.type = type
        self.metadata = metadata
        self.featureClasses = featureClasses
        self.featureRelationship = featureRelationship
    }
}