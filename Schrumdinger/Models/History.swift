//
//  History.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 21/06/25.
//

import Foundation
import SwiftData

@Model
class History: Identifiable {
    var id: UUID
    var date: Date
    var attendees: [Attendee]
    
    /// Each `DailyScrum` retains a one-to-many list of histories. Each `History` establishes an inverse relationship back to the `DailyScrum` in which it is contained.
    var dailyScrum: DailyScrum?
    var transcription: String?
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [Attendee], transcription: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.transcription = transcription
    }
}
