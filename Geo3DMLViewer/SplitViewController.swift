//
//  SplitViewController.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/2.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa
import SceneKit
//import SearchableOutlineView
class LeftSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        splitView.delegate = self
    }
    override func viewWillAppear() {
        super.viewWillAppear()
        splitView.setPosition(view.bounds.width / 6.0, ofDividerAt: 0)
    }

}

class RightSplitViewController: NSSplitViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        splitView.delegate = self
    }
    override func viewWillAppear() {
        super.viewWillAppear()
        splitView.setPosition(4.0 * view.bounds.width / 5.0, ofDividerAt: 0)
    }
}

class CenterSplitViewController: NSSplitViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitView.delegate = self
    }
    override func viewWillAppear() {
        super.viewWillAppear()
        splitView.setPosition(4.0 * view.bounds.height / 5.0, ofDividerAt: 0)
    }
}

class TopViewController: NSViewController{
    
    @IBOutlet weak var scnView: SCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
    }
    override func viewWillAppear() {
    }
}
class BottomViewController: NSViewController, NSTextViewDelegate{
    var log: Int = 1
    @IBOutlet var nsView: NSView!
    
    @IBOutlet var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.string = ""
        textView.delegate = self
        Logger.instance.addObserver(self, forKeyPath: "logMessageArray", options: NSKeyValueObservingOptions.new, context: nil)
        self.view.wantsLayer = true
    }
    override func viewWillAppear() {
        nsView.layer?.backgroundColor = NSColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1).cgColor
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "logMessageArray" {
            if let logMessage = change?[NSKeyValueChangeKey.newKey] as? [String]{
                self.textView?.string = logMessage.joined(separator: "")
            }
        }
    }
    @IBAction func showLogField(_ sender: NSButton) {
        let centerSplitViewController = self.parent as! NSSplitViewController
        if(log == 1){
            sender.image = NSImage(named: "bottom_up")
            log = 0
            centerSplitViewController.splitView.setPosition(centerSplitViewController.splitView.bounds.height, ofDividerAt: 0)
            //centerSplitview.setPosition(0, ofDividerAtIndex: 0)
        }else if(log == 0){
            sender.image = NSImage(named: "bottom_down")
            log = 1
            centerSplitViewController.splitView.setPosition(4 * centerSplitViewController.splitView.bounds.height/5, ofDividerAt: 0)
        }
        
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
        self.outlineView?.delegate = self
        self.searchField?.delegate = self
        
        self.nodes = []
        self.selectionIndexPaths = []
        self.renderTreeFromObjects(outlineContents, rootNode: nil)
    }
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        //print("FocusDelegate")
        if commandSelector == #selector(NSResponder.cancelOperation(_:)){
            searchField.stringValue = ""
            (self.treeController.content as AnyObject?)?.removeAllObjects()
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
    func searchFieldDidEndSearching(_ sender: NSSearchField) {
        Swift.print("开始查询...")
    }
    override func controlTextDidChange(_ obj: Notification) {
        if let searchField = obj.object as? NSSearchField{
            if searchField.stringValue.characters.count >= 2 {
                Logger.shareLogger().debug(items: "查询：\(searchField.stringValue)...")
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
    func outlineView(_ outlineView: NSOutlineView, shouldExpandItem item: Any) -> Bool {
        let node = (item as AnyObject).representedObject as! BaseNode
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
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool{
        return false
    }
    func outlineView(_ outlineView: NSOutlineView, viewFor viewForTableColumn: NSTableColumn?, item: Any) -> NSView?{
        let resultTextField = self.outlineView.make(withIdentifier: "ModelCell", owner: nil) as! NSTableCellView
        let node = (item as AnyObject).representedObject as! BaseNode
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
    func renderTreeFromObjects(_ entries: Dictionary<String, [String]>, rootNode: BaseNode?){
        for entry in entries{
            let groupName = entry.0
            let groupEntries = entry.1
            //print(groupEntries)
            let groupNode = BaseNode()
            groupNode.nodeTitle = groupName
            
            if rootNode != nil{
                groupNode.parent = rootNode
                rootNode?.children.add(groupNode)
                self.treeController.addChild(groupNode)
            }else{
                self.treeController.addObject(groupNode)
            }
            self.treeController.rearrangeObjects()
            
            for groupEntry in groupEntries{
                let node = BaseNode()
                node.nodeTitle = groupEntry
                node.parent = groupNode
                groupNode.children.add(node)
                //self.treeController.addChild(groupNode)
                self.treeController.rearrangeObjects()
            }
        }
    }
}
