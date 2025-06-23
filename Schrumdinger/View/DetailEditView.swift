//
//  DetailEditView.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 19/06/25.
//

import SwiftUI
import ThemeKit
import SwiftData

struct DetailEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var attendeeName = ""
    @State private var title: String
    @State private var lengthInMinutesAsDouble: Double
    @State private var theme: Theme
    @State private var attendees: [Attendee]
    
    let scrum: DailyScrum
    private let isCreatingScrum: Bool
    
    init(scrum: DailyScrum?) {
        let scrumToEdit: DailyScrum
        if let scrum = scrum {
            scrumToEdit = scrum
            isCreatingScrum = false
        } else {
            scrumToEdit = DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .bubblegum)
            isCreatingScrum = true
        }
        
        self.scrum = scrumToEdit
        self.title = scrumToEdit.title
        self.lengthInMinutesAsDouble = scrumToEdit.lengthInMinutesAsDouble
        self.attendees = scrumToEdit.attendees
        self.theme = scrumToEdit.theme
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
                HStack {
                    Slider(value: $lengthInMinutesAsDouble,
                           in: 5...30,
                           step: 1) {
                        Text("Length")
                    }
                           .accessibilityValue("\(lengthInMinutesAsDouble) minutes")
                    Spacer()
                    Text("\(String(format: "%.0f", lengthInMinutesAsDouble)) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $theme)
            } header: {
                Text("Meeting Info")
            }

            Section {
                ForEach(attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    attendees.remove(atOffsets: indices)
                }
                
                HStack {
                    TextField("New Attendee", text: $attendeeName)
                    Button {
                        withAnimation {
                            let attendee = Attendee(name: attendeeName)
                            attendees.append(attendee)
                            attendeeName = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add Attendee")
                    }
                    .disabled(attendeeName.isEmpty)

                }
            } header: {
                Text("Attendees")
            }

        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    saveEdits()
                    dismiss()
                }
            }
        }
    }
    
    private func saveEdits() {
        scrum.title = title
        scrum.lengthInMinutesAsDouble = lengthInMinutesAsDouble
        scrum.attendees = attendees
        scrum.theme = theme
        
        if isCreatingScrum {
            context.insert(scrum)
        }
        
        try? context.save()
    }
}

#Preview(traits: .dailyScrumsSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrum: [DailyScrum]
    DetailEditView(scrum: scrum[0])
}
