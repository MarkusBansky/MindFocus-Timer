//
//  PomodoroTimer.swift
//  PomodoroTimer
//
//  Created by Markiian Benovskyi on 17/07/2019.
//  Copyright © 2019 Markiian Benovskyi. All rights reserved.
//

import Foundation

class PomodoroTimer {
    var fiveMinuteTick: (() -> Void)?
    var twentyFiveMinuteTick: (() -> Void)?
    
    var focusingTimer: Timer?
    var restingTimer: Timer?
    
    var isFocusing: Bool
    
    init() {
        isFocusing = false
    }
    
    func startTimer() {
        isFocusing = true
        startFocusing()
        
        debugPrint("Started timer for focusing")
    }
    
    func stopTimer() {
        isFocusing = false
        
        focusingTimer?.invalidate()
        focusingTimer = nil
        
        restingTimer?.invalidate()
        restingTimer = nil
        
        debugPrint("Timer stopped")
    }
    
    private func startFocusing() {
        restingTimer?.invalidate()
        restingTimer = nil
        
        focusingTimer = Timer.scheduledTimer(
            withTimeInterval: 25.0,
            repeats: false,
            block: {(Timer) in self.focusingEnded()})
    }
    
    private func startResting() {
        focusingTimer?.invalidate()
        focusingTimer = nil
        
        restingTimer = Timer.scheduledTimer(
            withTimeInterval: 5.0,
            repeats: false,
            block: {(Timer) in self.restingEnded()})
    }
    
    private func focusingEnded() {
        // Run tick callback function
        twentyFiveMinuteTick?()
        
        startResting()
    }
    
    private func restingEnded() {
        // Run tick callback function
        fiveMinuteTick?()
        
        startFocusing()
    }
}
