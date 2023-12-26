//
//  ContentView.swift
//  PomodoroTimerTVExtension
//
//  Created by Sam.Siamon on 12/26/23.
//

import SwiftUI

struct PomodorTimerTVView: View {
    @StateObject private var viewModel = PomodoroTimerTVExtensionViewModel()
    private let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    var body: some View {
        VStack {
            if !viewModel.isActive {
                VStack {
                    Text("Focus for:")
                        .font(.title2)
                    HStack {
                        Button(action: {
                            viewModel.focusMinutes -= 1
                        }) {
                            Image(systemName: "minus.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(viewModel.focusMinutes == 1 ? .gray : .blue)
                        }
                        .disabled(viewModel.focusMinutes == 1)
                        Text("\(viewModel.focusTime)")
                            .font(.title3)
                        Button(action: {
                            viewModel.focusMinutes += 1
                        }) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .padding(.vertical, 50)
                VStack {
                    Text("Break for:")
                        .font(.title2)
                    HStack {
                        Button(action: {
                            viewModel.breakMinutes -= 1
                        }) {
                            Image(systemName: "minus.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(viewModel.breakMinutes == 1 ? .gray : .blue)
                        }
                        .disabled(viewModel.breakMinutes == 1)
                        Text("\(viewModel.breakTime)")
                            .font(.title3)
                        Button(action: {
                            viewModel.breakMinutes += 1
                        }) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .padding(.bottom, 50)
                VStack {
                    Text("Number of Cycles:")
                        .font(.title2)
                        .padding(.bottom, 5)
                    HStack {
                        Button(action: {
                            viewModel.cyclesCount -= 1
                        }) {
                            Image(systemName: "minus.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(viewModel.cyclesCount == 1 ? .gray : .blue)
                        }
                        .disabled(viewModel.cyclesCount == 1)
                        Text("\(viewModel.cyclesCount)")
                            .padding(.horizontal, 10)
                            .font(.title3)
                            .padding(.horizontal, 30)
                        Button(action: {
                            viewModel.cyclesCount += 1
                        }) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(viewModel.cyclesCount == 5 ? .gray : .blue)
                        }
                    }
                }
                .padding(.bottom, 50)
                Button(action: {viewModel.start()}) {
                    Text("START")
                        .font(.title2)
                        .foregroundStyle(.green)
                }
            } else {
                let focusActive = viewModel.focusIsActive
                let count = viewModel.cyclesCount - 1
                Text(focusActive ? "FOCUS" : "BREAK")
                    .font(.title)
                    .foregroundStyle(focusActive ? .purple : .cyan)
                    .padding(.top, 100)
                    .animation(.easeInOut, value: focusActive)
                Text("\(focusActive ? viewModel.focusTime : viewModel.breakTime)")
                    .font(.custom("SF Pro", size: 300))
                    .padding(.vertical, 50)
                Text("Cycles Remaining: \(count <= 0 ? 0 : count)")
                    .font(.title3)
                Button(action: {
                    viewModel.reset()
                }) {
                    Text("RESET")
                        .font(.title2)
                        .foregroundStyle(.red)
                }
            }
        }
        .animation(.easeInOut, value: viewModel.isActive)
        Spacer()
            .onReceive(timer) { _ in
                viewModel.updateCountdown()
            }
    }
}

#Preview {
    PomodorTimerTVView()
}
