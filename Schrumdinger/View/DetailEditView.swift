//
//  DetailEditView.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 19/06/25.
//

import SwiftUI

struct DetailEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var scrum: DailyScrum
    @State private var attendeeName = ""
    
    let saveEdits: (DailyScrum) -> Void
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble,
                           in: 5...30,
                           step: 1) {
                        Text("Length")
                    }
                           .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            } header: {
                Text("Meeting Info")
            }

            Section {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                
                HStack {
                    TextField("New Attendee", text: $attendeeName)
                    Button {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: attendeeName)
                            scrum.attendees.append(attendee)
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
                    saveEdits(scrum)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]
    DetailEditView(scrum: $scrum) { _ in
        
    }
}
