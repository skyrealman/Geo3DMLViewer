//
//  Node.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/9/6.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa
@objc class BaseNode: NSObject, SearchableNode{
    var nodeTitle: String? = nil
    var url: String? = nil
    var children: NSMutableArray = NSMutableArray()
    var originalChildren: NSMutableArray = NSMutableArray()
    weak var parent: SearchableNode?
    
    var searchableContent: String {
        get {
            return(self.nodeTitle == nil) ? "" : self.nodeTitle!
        }
    }
    func parentNode() -> SearchableNode? {
        return self.parent
    }
    func isLeaf() -> Bool{
        return self.children.count == 0
    }
}
