//
//  GeoFeature.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/8/30.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation
protocol GeoFeatureType: BaseType, AbstractFeature{
    var fields: Dictionary<String, String> {get set}
    var geometry: AbstractGeometry {get set}
}

protocol GeoFeatureClassType: BaseType, AbstractGML{
    var schema: Dictionary<String, String> {get set}
    var feature: [GeoFeatureType] {get set}
}

protocol GeoFeatureRelationType: BaseType, AbstractGML{
    var sourceRole: String {get set}
    var sourceFeature: GeoFeatureType {get set}
    var targetRole: String {get set}
    var targetFeature: [GeoFeatureType] {get set}
}

struct GeoFeature: GeoFeatureType{
    var annotation: String = ""
    var id: String?
    var name: String?
    var fields: Dictionary<String, String>
    var geometry: AbstractGeometry
}
struct GeoFeatureClass: GeoFeatureClassType{
    var annotation: String = ""
    var id: String?
    var name:String?
    var schema: Dictionary<String, String>
    var feature: [GeoFeatureType]
    init(schema: Dictionary<String, String>, feature: [GeoFeatureType]){
        self.schema = schema
        self.feature = feature
    }
}
struct GeologicHistory: GeoFeatureRelationType{
    var annotation: String = ""
    var id: String?
    var name: String?
    var sourceRole: String
    var sourceFeature: GeoFeatureType
    var targetRole: String
    var targetFeature: [GeoFeatureType]
}
