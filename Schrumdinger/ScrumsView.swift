//
//  ScrumsView.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 18/06/25.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack {
            List(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")

            }
        }
    }
}

#Preview {
    ScrumsView(scrums: DailyScrum.sampleData)
}
