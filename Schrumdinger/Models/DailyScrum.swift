//
//  DailyScrum.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 18/06/25.
//

import Foundation
import ThemeKit
import SwiftData


/// By annotating DailyScrum with @Model and class, this data model becomes a reference that swift manages.
@Model
class DailyScrum: Identifiable {
    var id: UUID
    var title: String
    
    /// cascade delete rule in the relationships indicate that if the parent object is deleted, the child objects are also deleted.
    /// This relationship designates `dailyScrum` property as their inverse relationship
    @Relationship(deleteRule: .cascade, inverse: \Attendee.dailyScrum)
    var attendees: [Attendee]
    
    var lengthInMinutes: Int
    var lengthInMinutesAsDouble: Double {
        get {
            Double(lengthInMinutes)
        }
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    var theme: Theme
    
    @Relationship(deleteRule: .cascade, inverse: \History.dailyScrum)
    var history = [History]()
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

//extension DailyScrum {
//    
//    static var emptyScrum: DailyScrum {
//        DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
//    }
//}
