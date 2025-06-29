//
//  ContentView.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 18/06/25.
//

import SwiftUI
import TimerKit
import AVFoundation
import TranscriptionKit

struct MeetingView: View {
    @Environment(\.modelContext) private var context
    @Binding var errorWrapper: ErrorWrapper?
    @State var scrumTimer = ScrumTimer()
    @State var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    let scrum: DailyScrum
    private let player = AVPlayer.dingPlayer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed,
                                  secondsRemaining: scrumTimer.secondsRemaining,
                                  theme: scrum.theme)
                MeetingTimerView(speakers: scrumTimer.speakers,
                                 isRecording: isRecording,
                                 theme: scrum.theme)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .onAppear {
            startScrum()
        }
        .onDisappear(perform: {
            do {
                try endScrum()
            } catch {
                errorWrapper = ErrorWrapper(error: error, guidance: "Meeting time was not recorded. Try again later!")
            }
        })
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendeeNames: scrum.attendees.map { $0.name })
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        scrumTimer.startScrum()
    }
    
    private func endScrum() throws {
        scrumTimer.stopScrum()
        speechRecognizer.stopTranscribing()
        isRecording = false
        let newHistory = History(attendees: scrum.attendees,
                                 transcription: speechRecognizer.transcript)
        scrum.history.insert(newHistory, at: 0)
        try context.save()
    }
}

#Preview {
    let scrum = DailyScrum.sampleData[0]
    MeetingView(errorWrapper: .constant(nil), scrum: scrum)
}
