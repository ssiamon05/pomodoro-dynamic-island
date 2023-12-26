//
//  PomodoroTimerView.swift
//  Pomodoro Timer
//
//  Created by Sam.Siamon on 12/5/23.
//

import SwiftUI

struct PomodoroTimerView: View {
    @StateObject private var viewModel = PomodoroTimerViewModel()
    private let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()

    var body: some View {
        VStack {
            if !viewModel.isActive {
                VStack {
                    Text("Focus for: \(viewModel.focusTime)")
                    Slider(value: $viewModel.focusMinutes, in: 1...20)
                }
                .padding(.bottom, 20)
                VStack {
                    Text("Break for: \(viewModel.breakTime)")
                    Slider(value: $viewModel.breakMinutes, in: 1...20)
                }
                .padding(.bottom, 20)
                VStack {
                    Text("Number of Cycles:")
                        .padding(.bottom, 10)
                    HStack {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(viewModel.cyclesCount == 1 ? .gray : .blue)
                            .onTapGesture {
                                viewModel.cyclesCount -= 1
                            }
                            .disabled(viewModel.cyclesCount == 1)
                        Text("\(viewModel.cyclesCount)")
                            .padding(.horizontal, 10)
                            .font(.title3)
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(viewModel.cyclesCount == 5 ? .gray : .blue)
                            .onTapGesture {
                                viewModel.cyclesCount += 1
                            }
                            .disabled(viewModel.cyclesCount == 5)
                    }
                }
                .padding(.bottom, 50)
                Button("START") {
                    viewModel.start()
                }
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 50)
                        .foregroundStyle(.green)
                }
            } else {
                let count = viewModel.cyclesCount - 1
                Text("Cycles Remaining: \(count <= 0 ? 0 : count)")
                if viewModel.focusIsActive {
                    Text("FOCUS")
                        .font(.title2)
                        .foregroundStyle(.purple)
                    Text("\(viewModel.focusTime)")
                } else {
                    Text("BREAK")
                        .font(.title2)
                        .foregroundStyle(.cyan)
                    Text("\(viewModel.breakTime)")
                }
                Button("RESET") {
                    viewModel.reset()
                }
            }
        }
        .padding(.horizontal, 20)
        .onReceive(timer) { _ in
            viewModel.updateCountdown()
        }

    }
}

#Preview {
    PomodoroTimerView()
}
