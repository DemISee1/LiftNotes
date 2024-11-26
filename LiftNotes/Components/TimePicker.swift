//
//  TimePicker.swift
//  LiftNotes
//
//  Created by Demessie Amede on 2024-10-17.
//

import SwiftUI

struct TimePicker: View {
    @State private var selectedMinutes: TimeInterval = 0
    @State private var selectedSeconds: TimeInterval = 0

    let minuteOptions = Array(0...59)
    let secondOptions = Array(0...59)
    
    var totalTime: TimeInterval {
        selectedMinutes * 60 + selectedSeconds
    }
    
    var onChange: (TimeInterval) -> Void

    var body: some View {
        VStack {
            HStack(spacing: 0){
                // Minute Picker
                Picker("Minutes", selection: $selectedMinutes) {
                    ForEach(minuteOptions, id: \.self) { minute in
                        Text("\(minute) min").tag(minute)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100)
                .onChange(of: selectedMinutes) {
                    onChange(totalTime)
                }
                
                // Second Picker
                Picker("Seconds", selection: $selectedSeconds) {
                    ForEach(secondOptions, id: \.self) { second in
                        Text("\(second) sec").tag(second)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100)
                .onChange(of: selectedSeconds) {
                    onChange(totalTime)
                }

            }
        }
    }
}

#Preview {
    TimePicker() { _ in }
}
