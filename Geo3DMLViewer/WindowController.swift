//
//  WindowController.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/2.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    var leftPanelFig = 1
    var bottomPanelFig = 1
    var rightPanelFig = 1
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.resize(800, 350)
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.titleVisibility = NSWindowTitleVisibility.Hidden
        self.window?.opaque = false
        self.window?.backgroundColor = NSColor.whiteColor().colorWithAlphaComponent(0.95)
    }
    func resize(width: Float, _ height: Float){
        var windowFrame = window?.frame
        let oldWidth = windowFrame!.size.width
        let oldHeight = windowFrame!.size.height
        windowFrame!.size = NSMakeSize(oldWidth + CGFloat(width), oldHeight + CGFloat(height))
        window?.setFrame(windowFrame!, display: true)
    }


    @IBAction func sideControl(sender: AnyObject) {
        let segment = sender.selectedSegment
        
        let leftSplitViewController = self.window?.contentViewController as! NSSplitViewController
        let rightSplitViewController = leftSplitViewController.splitViewItems[1].viewController as! NSSplitViewController
        let centerSplitViewController = rightSplitViewController.splitViewItems[0].viewController as! NSSplitViewController
        
        if(segment == 0){
            switch leftPanelFig {
            case 1:
                leftSplitViewController.splitViewItems[0].animator().collapsed = true
                leftPanelFig = 0
            case 0:
                leftSplitViewController.splitViewItems[0].animator().collapsed = false
                leftPanelFig = 1
            default: break
                
            }
        }else if(segment == 2){
            switch rightPanelFig {
            case 1:
                rightSplitViewController.splitViewItems[1].animator().collapsed = true
                rightPanelFig = 0
            case 0:
                rightSplitViewController.splitViewItems[1].animator().collapsed = false
                rightPanelFig = 1
            default: break
            }
        }else if(segment == 1){
            switch bottomPanelFig {
            case 1:
                centerSplitViewController.splitViewItems[1].animator().collapsed = true
                bottomPanelFig = 0
            case 0:
                centerSplitViewController.splitViewItems[1].animator().collapsed = false
                bottomPanelFig = 1
            default:
                break
            }
        }


    }

}