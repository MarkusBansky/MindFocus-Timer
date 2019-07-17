//
//  StatusMenuController.swift
//  PomodoroTimer
//
//  Created by Markiian Benovskyi on 17/07/2019.
//  Copyright © 2019 Markiian Benovskyi. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var startMenuItem: NSMenuItem!
    @IBOutlet weak var stopMenuItem: NSMenuItem!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    let pomodoroTimer = PomodoroTimer()
    
    override func awakeFromNib() {
        // Set status bar icon
        let icon = NSImage(named: "StatusBarIcon")
        statusItem.button?.image = icon
        statusItem.menu = statusMenu
        
        // Set callbacks for pomodoro
        pomodoroTimer.twentyFiveMinuteTick = self.twentyFiveMinuteTick
        pomodoroTimer.fiveMinuteTick = self.fiveminuteTick
    }
    
    func twentyFiveMinuteTick() {
        debugPrint("25 min TICK")
        self.notify(
            title: "Time to Relax",
            message: "Good! Now you have 5 minutes to relax.")
    }
    
    func fiveminuteTick() {
        debugPrint("5 min TICK")
        self.notify(
            title: "Now Focus",
            message: "You have 25 minutes to focus. Do not distract yourself.")
    }
    
    @IBAction func startPomodoroClicked(_ sender: NSMenuItem) {
        // Activate buttons
        startMenuItem.isEnabled = false
        stopMenuItem.isEnabled = true
        
        // Run timer
        pomodoroTimer.startTimer()
    }
    
    @IBAction func stopPomodoroClicked(_ sender: NSMenuItem) {
        pomodoroTimer.stopTimer()
        
        // Activate buttons
        startMenuItem.isEnabled = true
        stopMenuItem.isEnabled = false
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    private func notify(title: String, message: String) {
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = message
//        notification.hasActionButton = true
//        notification.hasReplyButton = false
        
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
}
