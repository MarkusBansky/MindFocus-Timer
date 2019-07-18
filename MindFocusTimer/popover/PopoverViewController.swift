//
//  PopoverViewController.swift
//  MindFocus Timer
//
//  Created by Markiian Benovskyi on 18/07/2019.
//  Copyright © 2019 Markiian Benovskyi. All rights reserved.
//

import Cocoa

class PopoverViewController: NSViewController {

    @IBOutlet weak var popover: NSPopover!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func awakeFromNib() {
        let popoverController = PopoverViewController(nibName: "PopoverViewController", bundle: nil)
        
        popover.contentViewController = popoverController
    }
    
}
