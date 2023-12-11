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
        let focusIsActive: Bool
        let breakIsActive: Bool
        let focusTime: String
        let focusMinutes: Float
        let breakTime: String
        let breakMinutes: Float
    }
}
