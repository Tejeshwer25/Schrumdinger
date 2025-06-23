//
//  SchrumdingerApp.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 18/06/25.
//

import SwiftUI
import SwiftData

@main
struct SchrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        /// WindowGroup is one of the primitive scenes that SwiftUI provides.
        /// In iOS, the views you add to the WindowGroup scene builder are presented in a window that fills the device’s entire screen
        WindowGroup {
            ScrumsView()
        }
        .modelContainer(for: DailyScrum.self)
    }
}
