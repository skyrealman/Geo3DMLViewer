//
//  geometry.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/8/30.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation
import SceneKit

protocol AbstractGeometry {
    var id: String {get set}
}
protocol AbstractGeometricPrimitive: AbstractGeometry{
    
}
protocol AbstractCurve: AbstractGeometricPrimitive {
    
}
protocol AbstractSurface: AbstractGeometricPrimitive {
    
}
protocol AbstractSolid: AbstractGeometricPrimitive {
    
}
//dimension must be a positive integer, I should make a PositiveInteger class
class GMLGrid: AbstractGeometry{
    var id: String{
        get{
            return self.id
        }
        set{
            self.id = newValue
        }
    }
    var dimension: Int
    init(id: String, dimension: Int){
        self.dimension = dimension
        self.id = id
    }
}
class GeoGrid: AbstractGeometry{
    var id: String{
        get{
            return self.id
        }
        set{
            self.id = newValue
        }
    }
    var grid: GMLGrid?
    var TransformationMatrix: matrix_double4x4?

}
class GMLPoint: AbstractGeometricPrimitive{
    var id: String{
        get{
            return self.id
        }
        set{
            self.id = newValue
        }
    }
}
class LineString: AbstractCurve{
    var id: String{
        get{
            return self.id
        }
        set{
            self.id = newValue
        }
    }
    var pos: [Double]?
}

class GeoTin: AbstractSurface{
    var id: String{
        get{
            return self.id
        }
        set{
            self.id = newValue
        }
    }
    
}