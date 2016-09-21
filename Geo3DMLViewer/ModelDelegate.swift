//
//  ModelDelegate.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/9/21.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa

protocol ModelDelegate{
    func checkModelFile() -> Bool
    func createModel()
    func renderModel()
    
}
