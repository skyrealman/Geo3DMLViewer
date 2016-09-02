//
//   SpatialReferenceSystem.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/8/30.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation

protocol AbstractSpatialReferenceSystem: BaseType{
    
}
struct SpatialReferenceSystemUsingGeographicIdentifiers: AbstractSpatialReferenceSystem {
    var annotation: String = ""
    var name: String
    init(name: String){
        self.name = name
    }
}
struct CoordinateReferenceSystem: AbstractSpatialReferenceSystem {
    var annotation: String = ""
    var coordinateReferenceSystemIdentifier: String
    var coordinateSystemType: String
    var coordinateSystemIdentifier: String
    var parameter: String
    init(coordinateReferenceSystemIdentifier: String, coordinateSystemType: String, coordinateSystemIdentifier: String, parameter: String){
        self.coordinateSystemType = coordinateSystemType
        self.coordinateSystemIdentifier = coordinateSystemIdentifier
        self.coordinateReferenceSystemIdentifier = coordinateReferenceSystemIdentifier
        self.parameter = parameter
    }
}
struct VerticalReferenceSystem: AbstractSpatialReferenceSystem {
    var annotation: String = ""
    var verticialReferenceSystem: String
    init(verticialReferenceSystem: String){
        self.verticialReferenceSystem = verticialReferenceSystem
    }
}