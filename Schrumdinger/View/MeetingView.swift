//
//  ContentView.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 18/06/25.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        VStack {
            ProgressView(value: 5, total: 100)
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.tophalf.fill")
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.bottomhalf.fill")
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Time Remaining")
            .accessibilityValue("10 minutes")
            // In above code we are modifying the voice over to pick the Time Remaining string as label instead of speaking out both the labels within the HStack
            
            Circle()
                .strokeBorder(lineWidth: 24)
            
            HStack {
                Text("Speaker 1 of 3")
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel("Next Speaker")

            }
        }
        .padding()
    }
}

#Preview {
    MeetingView()
}
