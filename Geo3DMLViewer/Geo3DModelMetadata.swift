//
//  Geo3DModelMetadata.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/8/30.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation
class Geo3DModelMetadata{
    var description: String
    var toolName: String
    var toolVersion: String
    var spatialReferenceSystem: AbstractSpatialReferenceSystem
    init(description: String, toolName: String, toolVersion: String, spatialReferenceSystem: AbstractSpatialReferenceSystem){
        self.description = description
        self.toolName = toolName
        self.toolVersion = toolVersion
        self.spatialReferenceSystem = spatialReferenceSystem
    }
}