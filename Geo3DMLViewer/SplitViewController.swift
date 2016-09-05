//
//  SplitViewController.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/2.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa

class LeftSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        splitView.delegate = self
    }
    override func viewWillAppear() {
        super.viewWillAppear()
        splitView.setPosition(view.bounds.width / 6.0, ofDividerAtIndex: 0)
    }

}

class RightSplitViewController: NSSplitViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        splitView.delegate = self
    }
    override func viewWillAppear() {
        super.viewWillAppear()
        splitView.setPosition(4.0 * view.bounds.width / 5.0, ofDividerAtIndex: 0)
    }
}

class CenterSplitViewController: NSSplitViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        splitView.delegate = self
    }
    override func viewWillAppear() {
        super.viewWillAppear()
        splitView.setPosition(4.0 * view.bounds.height / 5.0, ofDividerAtIndex: 0)
    }
}

class LeftViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
extension LeftViewController: NSOutlineViewDataSource, NSOutlineViewDelegate{
    var outlineTopHierarchy: [String]{
        return ["项目"]
    }
    var outlineContents: Dictionary<String,[String]>{
        let value: [String] = [ModelType.Drill.rawValue, ModelType.Section.rawValue, ModelType.Map3D.rawValue, ModelType.Isogram.rawValue, ModelType.Other.rawValue]
        return ["项目": value]
    }
    func childrenForItem(itemPassed: AnyObject?) -> Array<String>{
        if itemPassed != nil{
            return outlineContents["项目"]!
        }else{
            return outlineTopHierarchy
        }
    }
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        return childrenForItem(item)[index]
    }
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        if(outlineView.parentForItem(item) == nil){
            return true
        }else{
            return false
        }
    }
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        //print(childrenForItem(item).count)
        return childrenForItem(item).count
    }
    func outlineView(outlineView: NSOutlineView, viewForTableColumn: NSTableColumn?, item: AnyObject) -> NSView?{
        if let resultTextField = outlineView.makeViewWithIdentifier("ModelCell", owner: self) as? NSTableCellView{
            resultTextField.textField?.stringValue = item as! String
            resultTextField.imageView?.image = NSImage(named: "project") ?? nil
            print(NSImage(named: "project"))
            return resultTextField
            
        }
        return nil
    }
}