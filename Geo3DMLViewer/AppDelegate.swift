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

    
    @IBOutlet weak var newItem: NSMenuItem!
    @IBOutlet weak var openItem: NSMenuItem!
    
    @IBOutlet weak var checkItem: NSMenuItem!
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func openItemEvent(_ sender: AnyObject) {
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
                let path = result!.path
                let name = result!.lastPathComponent
                Logger.instance.debug(items: path)
                
                let progressbar = NSApplication.shared().mainWindow?.toolbar?.items[4].view as! ToolbarTextField
                progressbar.stringValue = " 打开 | \(name) 模型文件"
                progressbar.inProgress = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
                    progressbar.progress = 0.1
                    Logger.instance.debug(items: progressbar)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6)) {
                    progressbar.progress = 0.5
                    Logger.instance.debug(items: progressbar)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8)) {
                    progressbar.progress = 1.0
                    progressbar.inProgress = false
                    Logger.instance.debug(items: progressbar)
                }
                
                
            }
        }else{
            return
        }

    }
    @IBAction func newItemEvent(_ sender: AnyObject) {
        let desktopDirectoryURL = try! FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileDestinationUrl = desktopDirectoryURL.appendingPathComponent("t1.xml")
        let ma = ProjFileChecker(url: fileDestinationUrl)
        ma.fileCodeChecker(code: "utf8")
        guard
            let xmlPath = Bundle.main.path(forResource: "m1", ofType: "xml", inDirectory: "resources"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
        else { return }
        
        do {
            let xmlDoc = try DOMXMLDocument(xml: data)
            //print(xmlDoc.xml)
            for child in xmlDoc.root["Layers"]["Layer"].children{
                print(child.name)
            }
            print(xmlDoc.root["Layers"]["Layer"].children.count)
        } catch {
            print("\(error)")
        }
    }
    
    @IBAction func checkItemEvent(_ sender: AnyObject) {
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
                let path = result!.path
                let name = result!.lastPathComponent
                Logger.instance.debug(items: path)
                
                let progressbar = NSApplication.shared().mainWindow?.toolbar?.items[4].view as! ToolbarTextField
                progressbar.stringValue = " 打开 | \(name) 模型文件"
                
                let projFileChecker = ProjFileChecker(url: result!)
                progressbar.inProgress = true
                let fileList = projFileChecker.getFilePath()
                if let fileList = fileList{
                    for time in 0..<fileList.count{
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(time)) {
                            let mapFileChecker = MapFileChecker(path: fileList[time])
                            let modelFileChecker = ModelFileChecker(path: fileList[time])
                            if(mapFileChecker.getFileType() == "Geo3DMap"){
                                mapFileChecker.fileSyntaxChecker()
                            }else if (modelFileChecker.getFileType() == "GeoModel"){
                                modelFileChecker.fileSyntaxChecker()
                            }else{
                                
                            }
                            progressbar.progress =  CGFloat(time) / CGFloat(fileList.count)
                            progressbar.stringValue = " 检查 | \(fileList[time])文件"
                            if(time == fileList.count - 1){
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(fileList.count)) {
                                    progressbar.inProgress = false
                                    progressbar.stringValue = " 检查完毕 | 详情见日志"
                                }

                            }
                        }

                    }
                }
                
                //let _ = ma.getDictList()
                
            }
        }else{
            return
        }
    }
    
}

