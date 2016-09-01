//
//   SpatialReferenceSystem.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/8/30.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation
class AbstractSpatialReferenceSystem{
    
}
class SpatialReferenceSystemUsingGeographicIdentifiers: AbstractSpatialReferenceSystem{
    var name: String
    init(name: String){
        self.name = name
    }
}
class CoordinateReferenceSystem: AbstractSpatialReferenceSystem {
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
class VerticalReferenceSystem: AbstractSpatialReferenceSystem {
    var verticialReferenceSystem: String
    init(verticialReferenceSystem: String){
        self.verticialReferenceSystem = verticialReferenceSystem
    }
}