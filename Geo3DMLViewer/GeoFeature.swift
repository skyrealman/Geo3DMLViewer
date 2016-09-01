//
//  GeoFeature.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/8/30.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation
protocol AbstractGML {
    var id: String {get set}
    var name: String {get set}
}
protocol AbstractFeature: AbstractGML{
    
}
class GeoFeature: AbstractFeature{
    var fields: [Field]
    var geometry: AbstractGeometry
    var id: String{
        get{
            return self.id
        }
        set{
            self.id = newValue
        }
    }
    var name: String{
        get{
            return self.name
        }
        set{
            self.name = newValue
        }
    }
    
}
