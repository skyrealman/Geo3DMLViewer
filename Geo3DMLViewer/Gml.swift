//
//  Gml.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/9/1.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation
import SceneKit

protocol AbstractMemberType {
    var minOccurs: String {get set}
    var maxOccurs: String {get set}
}

protocol AbstractGML{
    var id: String? {get set}
    var name: String? {get set}
}
protocol AbstractGeometry: AbstractGML{
    
}
protocol AbstractGeometricPrimitive: AbstractGeometry {
    
}
protocol AbstractSurfaceType: AbstractGeometricPrimitive{
    var vertices:  [Vertex] {get set}
    var triangles: [Triangle]{get set}
    
}