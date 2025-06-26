//
//  DetailView.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 18/06/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let scrum: DailyScrum
    @State private var isPresentingEditView = false
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView(errorWrapper: $errorWrapper, scrum: scrum)) {
                    Label("Start meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundStyle(Color.accentColor)
                }
                
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                // VoiceOver then reads the two elements as one statement, for example, “Length, 10 minutes.”
                // Without the modifier, VoiceOver users have to swipe again between each element.
                
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text("\(scrum.theme.name)")
                        .padding(4)
                        .foregroundStyle(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                .accessibilityElement(children: .combine)
            }
            
            Section {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            } header: {
                Text("Attendee List")
            }
            
            Section {
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                } else {
                    ForEach(scrum.history) { history in
                        NavigationLink(destination: HistoryView(history: history)) {
                            HStack {
                                Image(systemName: "calendar")
                                Text(history.date, style: .date)
                            }
                        }
                    }
                }
            } header: {
                Text("History")
            }


        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(scrum: scrum)
                    .navigationTitle(scrum.title)
            }
        }
        .sheet(item: $errorWrapper, onDismiss: nil) { wrapper in
            ErrorView(errorWrapper: wrapper)
        }
    }
}

#Preview(traits: .dailyScrumsSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    NavigationStack {
        DetailView(scrum: scrums[0])
    }
}
