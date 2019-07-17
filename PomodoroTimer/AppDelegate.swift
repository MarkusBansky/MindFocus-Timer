//
//  AppDelegate.swift
//  PomodoroTimer
//
//  Created by Markiian Benovskyi on 17/07/2019.
//  Copyright © 2019 Markiian Benovskyi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    // Insert code here to initialize your application
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = "Pomodoro Timer"
        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

