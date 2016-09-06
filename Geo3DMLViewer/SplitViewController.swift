//
//  SplitViewController.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/2.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa
//import SearchableOutlineView
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

class LeftViewController: NSViewController, NSSearchFieldDelegate {
    
    @IBOutlet weak var outlineView: SearchableOutlineView!
    @IBOutlet weak var searchField: NSSearchField!
    
    @IBOutlet var treeController: NSTreeController!
    @IBOutlet var nodes: NSMutableArray?
    @IBOutlet var selectionIndexPaths: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.outlineView?.setDelegate(self)
        self.searchField?.delegate = self
        
        self.nodes = []
        self.selectionIndexPaths = []
        self.renderTreeFromObjects(outlineContents, rootNode: nil)
    }
    func control(control: NSControl, textView: NSTextView, doCommandBySelector commandSelector: Selector) -> Bool {
        print("FocusDelegate")
        if commandSelector == #selector(NSResponder.cancelOperation(_:)){
            searchField.stringValue = ""
            self.treeController.content?.removeAllObjects()
            self.treeController.rearrangeObjects()
            self.renderTreeFromObjects(outlineContents, rootNode: nil)
            control.abortEditing()
            return true
        }
        return false
    }
    
}
extension LeftViewController: NSOutlineViewDataSource, NSOutlineViewDelegate{
    var outlineTopHierarchy: [String]{
        return ["工作空间"]
    }
    var outlineContents: Dictionary<String,[String]>{
        let value: [String] = [ModelType.Drill.rawValue, ModelType.Section.rawValue, ModelType.Map3D.rawValue, ModelType.Isogram.rawValue, ModelType.Other.rawValue]
        return ["工作空间": value]
    }
    func searchFieldDidEndSearching(sender: NSSearchField) {
        Swift.print("开始查询...")
    }
    override func controlTextDidChange(obj: NSNotification) {
        if let searchField = obj.object as? NSSearchField{
            if searchField.stringValue.characters.count >= 2 {
                Swift.print("查询：\(searchField.stringValue)...")
                try! self.outlineView.filterNodesTree(withString: searchField.stringValue)
            }
            if searchField.stringValue.characters.count == 0{
                try! self.outlineView.filterNodesTree(withString: nil)
            }
        }
    }
//    func childrenForItem(itemPassed: AnyObject?) -> Array<String>{
//        if itemPassed != nil{
//            return outlineContents["工作空间"]!
//        }else{
//            return outlineTopHierarchy
//        }
//    }
//    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
//        return childrenForItem(item)[index]
//    }
    func outlineView(outlineView: NSOutlineView, shouldExpandItem item: AnyObject) -> Bool {
        let node = item.representedObject as! BaseNode
        if node.parentNode() == nil{
            return true
        }else if node.parentNode()?.parentNode() == nil && node.parentNode() != nil{
            return true
        }else{
            return false
        }
    }
//    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
//        //print(childrenForItem(item).count)
//        return childrenForItem(item).count
//    }
    func outlineView(outlineView: NSOutlineView, isGroupItem item: AnyObject) -> Bool{
        return false
    }
    func outlineView(outlineView: NSOutlineView, viewForTableColumn: NSTableColumn?, item: AnyObject) -> NSView?{
        let resultTextField = self.outlineView.makeViewWithIdentifier("ModelCell", owner: nil) as! NSTableCellView
        let node = item.representedObject as! BaseNode
        if let title = node.nodeTitle{
            resultTextField.textField?.stringValue = title
        }else{
            resultTextField.textField?.stringValue = "?"
        }
        
        if node.parentNode() == nil{
            resultTextField.imageView?.image = NSImage(named: "project")
        }else if node.parentNode() != nil && node.parentNode()?.parentNode() == nil{
            resultTextField.imageView?.image = NSImage(named: "model")
        }else{
            resultTextField.imageView?.image = NSImage(named: "click")
        }
        
            //print(NSImage(named: "project"))
        return resultTextField
        
    }
    func renderTreeFromObjects(entries: Dictionary<String, [String]>, rootNode: BaseNode?){
        for entry in entries{
            let groupName = entry.0
            let groupEntries = entry.1
            print(groupEntries)
            let groupNode = BaseNode()
            groupNode.nodeTitle = groupName
            
            if rootNode != nil{
                groupNode.parent = rootNode
                rootNode?.children.addObject(groupNode)
                self.treeController.addChild(groupNode)
            }else{
                self.treeController.addObject(groupNode)
            }
            self.treeController.rearrangeObjects()
            
            for groupEntry in groupEntries{
                let node = BaseNode()
                node.nodeTitle = groupEntry
                node.parent = groupNode
                groupNode.children.addObject(node)
                //self.treeController.addChild(groupNode)
                self.treeController.rearrangeObjects()
            }
        }
    }
}