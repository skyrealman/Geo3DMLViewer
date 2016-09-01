//
//  Base.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/9/1.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Foundation
import SceneKit

enum ModelType: String {
    case Drill = "钻孔"
    case Section = "剖面"
    case Model = "三维地质模型"
    case Isogram = "等值图"
    case Other = "其它"
}

struct PosList{
    var srsDimension: Int
    var count: Int
    var points: [SCNVector3]
    init(srsDimension: Int, count: Int, points: [SCNVector3]){
        self.count = count
        self.srsDimension = srsDimension
        self.points = points
    }
}

struct Vertex{
    var indexNo: Int
    var srsDimension: Int
    var points: [SCNVector3]
    init(indexNo: Int, srsDimension: Int, points: [SCNVector3]){
        self.indexNo = indexNo
        self.srsDimension = srsDimension
        self.points = points
    }
}

struct Triangle {
    var indexNo: Int
    var vertexList: [Int]
    var neighborList: [Int]
    init(indexNo: Int, vertexList: [Int], neighborList: [Int]){
        self.indexNo = indexNo
        self.neighborList = neighborList
        self.vertexList = vertexList
    }
}