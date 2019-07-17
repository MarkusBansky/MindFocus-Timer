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
    @IBOutlet weak var focusingStatusItem: NSMenuItem!
    
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
        pomodoroTimer.secondsTick = self.secondsTick
    }
    
    func secondsTick(_ remaining: Int) {
        let prefix = pomodoroTimer.isFocusing ? "Focusing:" : "Relaxing:"
        let minutes = Int(remaining / 60)
        let seconds = Int(remaining - minutes * 60)
        self.setTitle("\(prefix) \(minutes)m \(seconds)s")
    }
    
    func twentyFiveMinuteTick() {
        debugPrint("25 min TICK")
        
        self.notify(
            title: "Time to Relax",
            subtitle: "5 minutes",
            message: "Good! Now you have 5 minutes to relax.")
    }
    
    func fiveminuteTick() {
        debugPrint("5 min TICK")
        
        self.notify(
            title: "Now Focus",
            subtitle: "25 minutes",
            message: "You have 25 minutes to focus. Do not distract yourself.")
    }
    
    @IBAction func startPomodoroClicked(_ sender: NSMenuItem) {
        // Activate buttons
        startMenuItem.isEnabled = false
        stopMenuItem.isEnabled = true
        
        // Run timer
        pomodoroTimer.startTimer()
        self.setTitle("Focusing")
        
        self.notify(
            title: "Timer started",
            subtitle: "Now focus",
            message: "You have 25 minutes to focus. Do not distract yourself.")
    }
    
    @IBAction func stopPomodoroClicked(_ sender: NSMenuItem) {
        pomodoroTimer.stopTimer()
        self.setTitle("Start timer to focus")
        
        // Activate buttons
        startMenuItem.isEnabled = true
        stopMenuItem.isEnabled = false
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    private func setTitle(_ title: String) {
        focusingStatusItem.title = title
    }
    
    private func notify(title: String, subtitle: String, message: String) {
        let notification = NSUserNotification()
        notification.title = title
        notification.subtitle = subtitle
        notification.informativeText = message
        notification.hasActionButton = false
        notification.hasReplyButton = false
        
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
}
