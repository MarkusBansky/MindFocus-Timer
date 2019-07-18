//
//  PomodoroTimer.swift
//  PomodoroTimer
//
//  Created by Markiian Benovskyi on 17/07/2019.
//  Copyright © 2019 Markiian Benovskyi. All rights reserved.
//

import Foundation

class PomodoroTimer {
    var secondsTick: ((_ left: Int) -> Void)?
    var fiveMinuteTick: (() -> Void)?
    var twentyFiveMinuteTick: (() -> Void)?
    
    var focusingTimer: Timer?
    var restingTimer: Timer?
    var tickTimer: Timer?
    
    var isFocusing: Bool
    var start: CFAbsoluteTime!
    
    let focusingTime = 1500.0
    let relaxingTime = 300.0
    
    init() {
        // Initialise the focusing variable to false
        isFocusing = false
    }
    
    func startTimer() {
        // Set the ticking timer that ticks each second
        // and displays the remaining time in menu
        tickTimer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true,
            block: {(Timer) in self.tickSeconds()})
        
        // Add this timer to run loop to prevent hault
        // when the menu is opened
        RunLoop.main.add(tickTimer!, forMode: .common)
        
        // Start the focusing cycle
        startFocusing()
        
        // Debug
        debugPrint("Started timer for focusing")
    }
    
    func stopTimer() {
        // Set facusing as false
        isFocusing = false
        
        // Remove timer from the main running loop
//        RunLoop.main.remove(tickTimer, forMode: RunLoopMode.common)
        
        // Invalidate all timers
        tickTimer?.invalidate()
        tickTimer = nil
        
        focusingTimer?.invalidate()
        focusingTimer = nil
        
        restingTimer?.invalidate()
        restingTimer = nil
        
        // Debug
        debugPrint("Timer stopped")
    }
    
    private func tickSeconds() {
        // Get difference in seconds passed
        let diff = (CFAbsoluteTimeGetCurrent() - start)
        
        // Get seconds left depending on state
        let secondsLeft = (isFocusing ? focusingTime : relaxingTime) - diff
        
        // Debug
        debugPrint(secondsLeft)
        
        // Fire callback function to display UI
        self.secondsTick!(Int(secondsLeft))
    }
    
    private func startFocusing() {
        // Set facusing to true
        isFocusing = true
        
        // Stop resting timer
        restingTimer?.invalidate()
        restingTimer = nil
        
        // Start new focusing timer
        start = CFAbsoluteTimeGetCurrent()
        focusingTimer = Timer.scheduledTimer(
            withTimeInterval: focusingTime,
            repeats: false,
            block: {(Timer) in self.focusingEnded()})
    }
    
    private func startResting() {
        // Set focusing to false
        isFocusing = false
        
        // Stop focusing timer
        focusingTimer?.invalidate()
        focusingTimer = nil
        
        // Start resting timer
        start = CFAbsoluteTimeGetCurrent()
        restingTimer = Timer.scheduledTimer(
            withTimeInterval: relaxingTime,
            repeats: false,
            block: {(Timer) in self.restingEnded()})
    }
    
    private func focusingEnded() {
        // Run tick callback function
        twentyFiveMinuteTick?()
        
        // Start resting loop
        startResting()
    }
    
    private func restingEnded() {
        // Run tick callback function
        fiveMinuteTick?()
        
        // Start focusing loop
        startFocusing()
    }
}
