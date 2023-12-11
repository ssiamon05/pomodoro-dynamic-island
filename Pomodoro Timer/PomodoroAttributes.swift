//
//  PomodoroAttributes.swift
//  Pomodoro Timer
//
//  Created by Sam.Siamon on 12/7/23.
//

import Foundation
import ActivityKit

struct PomodoroAttributes: ActivityAttributes {
    typealias ContentState = PomodoroState

    struct PomodoroState: Codable, Hashable {
        var focusIsActive: Bool
        var breakIsActive: Bool
        var focusTime: String
        var focusMinutes: Float
        var breakTime: String
        var breakMinutes: Float
        var cyclesCount: Int
    }
}
