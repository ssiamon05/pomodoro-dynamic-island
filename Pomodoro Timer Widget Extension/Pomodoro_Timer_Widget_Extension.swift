//
//  Pomodoro_Timer_Widget_Extension.swift
//  Pomodoro Timer Widget Extension
//
//  Created by Sam.Siamon on 12/5/23.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct Pomodoro_Timer_Widget_Extension: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PomodoroAttributes.self) { context in
            PomodoroWidgetView(time: context.state.focusTime)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundStyle(context.state.focusIsActive ? .purple : .cyan)
                        Text(context.state.focusIsActive ? context.state.focusTime : context.state.breakTime)
                            .padding(.horizontal, 10)
                        Text(context.state.focusIsActive ? "FOCUS" : "BREAK")
                            .foregroundStyle(context.state.focusIsActive ? .purple : .cyan)
                    }
                }
            } compactLeading: {
                Image(systemName: "clock.fill")
                    .foregroundStyle(context.state.focusIsActive ? .purple : .cyan)
            } compactTrailing: {
                Text(context.state.focusIsActive ? context.state.focusTime : context.state.breakTime)
            } minimal: {
                Text(context.state.focusIsActive ? context.state.focusTime : context.state.breakTime)
            }
        }
        .configurationDisplayName("Pomodoro Status")
        .description("Shows your current timer")
        .supportedFamilies([.systemSmall])
    }
}

struct PomodoroWidgetView: View {
    var time: String
    var body: some View {
        VStack {
            Text("\(time)")
        }
    }
}
