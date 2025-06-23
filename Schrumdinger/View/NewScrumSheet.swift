//
//  NewScrumSheet.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 21/06/25.
//

import SwiftUI

struct NewScrumSheet: View {
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: nil)
        }
    }
}

#Preview {
    NewScrumSheet()
}
