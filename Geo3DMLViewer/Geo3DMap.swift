//
//  Geo3DMap.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/8/30.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation

class Geo3DMap {
    var name: String
    var description: String
    var layers: [Geo3DLayer]
    
    init(name: String, description: String, layers: [Geo3DLayer]){
        self.name = name
        self.description = description
        self.layers = layers
    }
}