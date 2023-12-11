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
            PomodoroWidgetView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundStyle(context.state.focusIsActive ? .purple : .cyan)
                        Text(context.state.focusIsActive ? context.state.focusTime : context.state.breakTime)
                            .contentTransition(.numericText())
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
                    .contentTransition(.numericText())
            } minimal: {
                Text(context.state.focusIsActive ? context.state.focusTime : context.state.breakTime)
                    .contentTransition(.numericText())
            }
        }
        .configurationDisplayName("Pomodoro Status")
        .description("Shows your current timer")
        .supportedFamilies([.systemSmall])
    }
}

struct PomodoroWidgetView: View {
    var context: ActivityViewContext<PomodoroAttributes>
    var body: some View {
        HStack {
            Image(systemName: "clock.fill")
                .foregroundStyle(context.state.focusIsActive ? .purple : .cyan)
            Text(context.state.focusIsActive ? context.state.focusTime : context.state.breakTime)
                .contentTransition(.numericText())
                .padding(.horizontal, 10)
            Text(context.state.focusIsActive ? "FOCUS" : "BREAK")
                .foregroundStyle(context.state.focusIsActive ? .purple : .cyan)
        }
    }
}
