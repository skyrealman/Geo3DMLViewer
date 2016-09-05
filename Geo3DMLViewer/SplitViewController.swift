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

class OutlineViewController: NSViewController{
    
    @IBAction func showOutline(sender: NSButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}