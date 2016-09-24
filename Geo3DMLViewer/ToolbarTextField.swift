//
//  ToolbarTextField.swift
//  Geo3DMLViewer
//
//  Created by SongZhen on 16/9/4.
//  Copyright © 2016年 skyrealman. All rights reserved.
//

import Cocoa

class ToolbarTextField: NSTextField {
    
    var button = NSButton()
    var inProgress: Bool = false{
        didSet{
            self.needsDisplay = true
            self.button.isHidden = !self.inProgress
            self.button.needsDisplay = true
            self.button.isEnabled = true
        }
    }
    var progress: CGFloat = CGFloat(0.0) {
        didSet{
            self.needsDisplay = true
            self.button.needsDisplay = true
        }
    }
    var viewController: NSViewController? = nil{
        didSet{
            self.button.target = self.viewController
            self.button.action = Selector(("cancelLoadingButtonClicked:"))
        }
    }
    override func awakeFromNib() {
        let buttonFrame = NSMakeRect(0.0, 0.0, 16.0, 16.0)
        self.button = NSButton(frame: buttonFrame)
        self.button.setButtonType(NSButtonType.momentaryChange)
        self.button.bezelStyle = NSBezelStyle.regularSquare
        self.button.isBordered = false
        self.button.imagePosition = NSCellImagePosition.imageOnly
        self.button.image = NSImage(named: NSImageNameStopProgressFreestandingTemplate)
        self.button.isHidden = !self.inProgress
        
        self.addSubview(self.button)
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if self.inProgress{
            let buttonFrame = NSMakeRect(self.bounds.size.width - 22, ceil((self.bounds.size.height / 2) - 9), 16.0, 16.0)
            self.button.frame = buttonFrame
            var progressRect = self.bounds
            progressRect.origin.y = progressRect.size.height - 4
            progressRect.size.height = 2
            progressRect.size.width *= self.progress
            NSColor.alternateSelectedControlColor.set()
            
            // 需要完善，看看如何给渲染添加动画
            NSAnimationContext.runAnimationGroup({ (context) -> Void in
                context.duration = 1
                context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
                NSRectFillUsingOperation(progressRect, NSCompositingOperation.sourceIn)
                }, completionHandler: {() -> Void in
                    
                    
                    
            })
        }
    }
    
    
}
