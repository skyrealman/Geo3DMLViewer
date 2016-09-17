//
//  SearchableOutlineView.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/9/6.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa
extension NSIndexPath {
    
    func lastIndex() -> Int {
        return self.index(atPosition: self.length-1);
    }
    
    func indexPathByAddingIndexPath(indexPath: NSIndexPath?) -> NSIndexPath {
        var path = self.copy() as! NSIndexPath
        if let ip = indexPath {
            for position in 0..<ip.length {
                path = path.adding(ip.index(atPosition: position)) as NSIndexPath
            }
        }
        return path
    }
    
    func indexPathByAddingIndexInFront(index: Int) -> NSIndexPath {
        let indexPath = NSIndexPath(index: index)
        return indexPath.indexPathByAddingIndexPath(indexPath: self)
    }
}

public protocol SearchableNode: NSObjectProtocol {
    var children: NSMutableArray { get set }
    var originalChildren: NSMutableArray { get set }
    
    func hash() -> Int
    var searchableContent: String { get }
    
    func parentNode() -> SearchableNode?
    func indexPath() -> NSIndexPath
}

public extension Collection where Iterator.Element == SearchableNode {
    func indexOf(element: Iterator.Element) -> Index? {
        return index(where: { $0.hash() == element.hash() })
    }
}

public extension SearchableNode {
    // This assume the content in a node is always unique!
    func hash() -> Int {
        return self.searchableContent.hash
    }
    
    func indexPath() -> NSIndexPath {
        var indexPath = NSIndexPath()
        var activeNode: SearchableNode = self
        
        while activeNode.parentNode() != nil {
            let index = activeNode.parentNode()!.children.index(of: self)
            indexPath = indexPath.indexPathByAddingIndexInFront(index: index)
            activeNode = activeNode.parentNode()!
        }
        
        return indexPath
    }
}

enum SearchableOutlineViewError: Error {
    case missingTreeController
}

public class SearchableOutlineView: NSOutlineView {
    
    @IBOutlet var treeController: NSTreeController?
    
    private var filter: String = ""
    
    public func filterNodesTree(withString newFilter: String?) throws {
        guard newFilter != nil && (newFilter?.characters.count)! >= 2, let filter = newFilter else {
            self.filter = ""
            return
        }
        
        guard self.treeController != nil else {
            throw SearchableOutlineViewError.missingTreeController
        }
        
        self.filter = filter
        let flatNodes = recursivePreorderTraversal(nodes: ((self.treeController!.arrangedObjects as AnyObject).children))
        Swift.print((flatNodes[1] as! BaseNode).nodeTitle)
        let filteredNodes = flatNodes.filter({ $0.searchableContent.lowercased().range(of: filter.lowercased()) != nil })
        Swift.print(filteredNodes.count)
        let filteredLeafNodes = filteredNodes.filter({ $0.children == nil || $0.children.count == 0 })
        
        if filteredLeafNodes.count == 0 {
            //找不到查询内容
            return
        }
        
        var rootNodes: [SearchableNode] = []
        
        // Rebuild the tree from the leaves...
        
        // Move aside all regular children into a temporary array
        for leafNode in filteredLeafNodes {
            if let parentNode = leafNode.parentNode() {
                if parentNode.originalChildren.count == 0 && parentNode.children.count > 0 {
                    parentNode.originalChildren.addObjects(from: parentNode.children as [AnyObject])
                    parentNode.children.removeAllObjects()
                }
            }
        }
        
        // Re-introduce only valid one.
        for leafNode in filteredLeafNodes {
            if let parentNode = leafNode.parentNode() {
                parentNode.children.add(leafNode)
            }
            
            var rootNode = leafNode
            while rootNode.parentNode() != nil {
                rootNode = rootNode.parentNode()!
            }
            rootNodes.append(rootNode)
        }
        Swift.print("=====" + (String)(rootNodes.count))
        (self.treeController?.content as AnyObject?)?.removeAllObjects()
        self.treeController?.rearrangeObjects()
        
        let indexSet = NSMutableIndexSet()
        for (index, rootNode) in rootNodes.enumerated() {
            self.treeController?.insert(rootNode, atArrangedObjectIndexPath: NSIndexPath(index: index) as IndexPath)
            indexSet.add(index)
        }
        
        for index in indexSet {
            self.expandItem(self.item(atRow: index), expandChildren: true)
        }
    }
    
    func recursivePreorderTraversal(nodes: [NSTreeNode]?) -> Array<SearchableNode> {
        if nodes == nil {
            return []
        }
        var result: [SearchableNode] = []
        result += nodes!.filter({ $0.representedObject != nil }).map({ return $0.representedObject! as! SearchableNode })
        for node in nodes! {
            result += recursivePreorderTraversal(nodes: node.children)
        }
        return result
    }
}
