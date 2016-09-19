//
//  AppDelegate.swift
//  Geo3DMLViewer
//
//  Created by skyrealman on 16/9/1.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func openEvent(_ sender: AnyObject) {
        let openDialog = NSOpenPanel()
        openDialog.title = "打开三维模型"
        openDialog.showsResizeIndicator = true
        openDialog.showsHiddenFiles = false
        openDialog.canChooseDirectories = false
        openDialog.canCreateDirectories = false
        openDialog.allowsMultipleSelection = false
        openDialog.allowedFileTypes = ["xml"]
        
        if(openDialog.runModal() == NSModalResponseOK){
            let result = openDialog.url
            if(result != nil){
                let path = result?.path
                Logger.instance.debug(items: path)
                
            }
        }else{
            return
        }
    }

}

