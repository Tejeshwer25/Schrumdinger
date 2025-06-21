//
//  NewScrumSheet.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 21/06/25.
//

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum = DailyScrum.emptyScrum
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum) { dailyScrum in
                scrums.append(dailyScrum)
            }
        }
    }
}

#Preview {
    NewScrumSheet(scrums: .constant(DailyScrum.sampleData))
}
