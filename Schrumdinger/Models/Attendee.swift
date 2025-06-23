//
//  Attendee.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 22/06/25.
//

import Foundation
import SwiftData

@Model
class Attendee: Identifiable {
    var id: UUID
    var name: String
    
    /// Each `DailyScrum` retains a one-to-many list of attendees. Each `Attendee` establishes an inverse relationship back to daily scrum in which it is contained. 
    var dailyScrum: DailyScrum?
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
