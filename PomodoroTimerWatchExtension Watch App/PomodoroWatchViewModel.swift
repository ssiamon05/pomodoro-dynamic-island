//
//  PomodoroWatchViewModel.swift
//  PomodoroTimerWatchExtension Watch App
//
//  Created by Sam.Siamon on 12/19/23.
//

import Foundation

final class PomodoroWatchViewModel: ObservableObject {
    @Published var isActive = false
    @Published var focusIsActive = false
    @Published var breakIsActive = false
    @Published var focusTime: String = "5:00"
    @Published var breakTime: String = "5:00"
    @Published var focusMinutes: Float = 5.0 {
        didSet {
            self.focusTime = "\(Int(focusMinutes)):00"
        }
    }
    @Published var breakMinutes: Float = 5.0 {
        didSet {
            self.breakTime = "\(Int(breakMinutes)):00"
        }
    }
    @Published var cyclesCount = 1
    private var initialTime = 0
    private var initialFocusTime = 0
    private var initialFocusMinutes: Float = 0
    private var initialBreakMinutes: Float = 0
    private var initialBreakTime = 0
    private var initialCyclesCount = 0
    private var endDate = Date()
    private var focusEndDate = Date()
    private var breakEndDate = Date()
    @Published var focusTimer: Timer.TimerPublisher?
    @Published var breakTimer: Timer.TimerPublisher?

    func setup() {
        self.initialFocusMinutes = focusMinutes
        self.initialBreakMinutes = breakMinutes
        self.initialCyclesCount = cyclesCount
    }

    // Start the timer with the given amount of minutes
    func start() {
        setup()
        self.initialTime = Int(focusMinutes + breakMinutes) * cyclesCount
        self.endDate = Date()
        self.isActive = true
        self.endDate = Calendar.current.date(byAdding: .minute, value: Int((focusMinutes + breakMinutes) * Float(cyclesCount)), to: endDate)!
        startFocus()
    }

    func startFocus() {
        self.focusMinutes = initialFocusMinutes
        self.focusEndDate = Date()
        self.focusIsActive = true
        self.focusEndDate = Calendar.current.date(byAdding: .minute, value: Int(focusMinutes), to: focusEndDate)!
        focusTimer = Timer.publish(every: 1, on: .main, in: .common)
        _ = focusTimer?.autoconnect()
    }

    func startBreak() {
        self.breakMinutes = initialBreakMinutes
        self.breakEndDate = Date()
        self.breakIsActive = true
        self.breakEndDate = Calendar.current.date(byAdding: .minute, value: Int(breakMinutes), to: breakEndDate)!
        breakTimer = Timer.publish(every: 1, on: .main, in: .common)
        _ = breakTimer?.autoconnect()
    }

    // Reset the timer
    func reset() {
        self.focusMinutes = initialFocusMinutes
        self.focusTime = "\(Int(focusMinutes)):00"
        self.breakMinutes = initialBreakMinutes
        self.breakTime = "\(Int(breakMinutes)):00"
        self.cyclesCount = initialCyclesCount
        self.isActive = false
    }

    // Show updates of the timer
    func updateCountdown() {
        guard isActive else { return }
        if cyclesCount > 0 {
            if focusIsActive {
                // Gets the current date and makes the time difference calculation
                let now = Date()
                let diff = focusEndDate.timeIntervalSince1970 - now.timeIntervalSince1970

                // Checks that the countdown is not <= 0
                if diff <= 0 {
                    self.focusIsActive = false
                    self.focusTime = "0:00"
                    focusTimer = nil
                    startBreak()
                    return
                }

                // Turns the time difference calculation into sensible data and formats it
                let date = Date(timeIntervalSince1970: diff)
                let calendar = Calendar.current
                let minutes = calendar.component(.minute, from: date)
                let seconds = calendar.component(.second, from: date)

                // Updates the time string with the formatted time
                self.focusMinutes = Float(minutes)
                self.focusTime = String(format:"%d:%02d", minutes, seconds)
            } else {
                // Gets the current date and makes the time difference calculation
                let now = Date()
                let diff = breakEndDate.timeIntervalSince1970 - now.timeIntervalSince1970

                // Checks that the countdown is not <= 0
                if diff <= 0 {
                    self.breakIsActive = false
                    self.breakTime = "0:00"
                    breakTimer = nil
                    cyclesCount -= 1
                    if cyclesCount != 0 {
                        startFocus()
                    }
                    return
                }

                // Turns the time difference calculation into sensible data and formats it
                let date = Date(timeIntervalSince1970: diff)
                let calendar = Calendar.current
                let minutes = calendar.component(.minute, from: date)
                let seconds = calendar.component(.second, from: date)

                // Updates the time string with the formatted time
                self.breakMinutes = Float(minutes)
                self.breakTime = String(format:"%d:%02d", minutes, seconds)
            }
        } else {
            reset()
        }
    }
}
