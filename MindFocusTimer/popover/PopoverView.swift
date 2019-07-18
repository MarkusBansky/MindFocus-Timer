//
//  PopoverView.swift
//  MindFocus Timer
//
//  Created by Markiian Benovskyi on 18/07/2019.
//  Copyright © 2019 Markiian Benovskyi. All rights reserved.
//

import Cocoa

class PopoverView: NSView {
    @IBOutlet weak var popover: NSPopover!
    @IBOutlet weak var popoverController: NSViewController!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func awakeFromNib() {
        popover.contentViewController = popoverController
    }
    
}
