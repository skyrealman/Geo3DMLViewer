//
//  geometry.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/8/30.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation
import SceneKit


struct GeoTin: AbstractSurfaceType{
    var id: String?{
        get{
            return self.id
        }
        set{
            self.id = newValue
        }
    }
    var name: String?{
        get{
            return self.name
        }
        set{
            self.name = newValue
        }
    }
    var vertices:  [Vertex]{
        get{
            return self.vertices
        }
        set{
            self.vertices = newValue
        }
    }
    var triangles: [Triangle]{
        get{
            return self.triangles
        }
        set{
            self.triangles = newValue
        }
    }
    init(id: String?, name: String?, vertices: [Vertex], triangles: [Triangle]){
        self.id = id
        self.name = name
        self.vertices = vertices
        self.triangles = triangles
    }
}
extension GeoTin: CustomStringConvertible{
    var description: String {
        get{
            return "Tin Model \(id) has \(vertices.count) vertices and \(triangles.count) triangles"
        }
    }
}