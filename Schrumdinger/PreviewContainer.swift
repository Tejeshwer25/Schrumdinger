//
//  PreviewContainer.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 22/06/25.
//

import SwiftData
import SwiftUI

struct DailyScrumSampleData: PreviewModifier {
    
    /// To conform to the PreviewModifier protocol, you need to define a `makeSharedContext()` method.
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(for: DailyScrum.self, configurations: .init(isStoredInMemoryOnly: true))
        DailyScrum.sampleData.forEach { container.mainContext.insert($0) }
        return container
        /// A container manages storage in `SwiftData`. When you fetch or save data, the container performs the reading and writing of underlying data using information of schema that you established in your `SwiftData` models.
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var dailyScrumsSampleData: Self = .modifier(DailyScrumSampleData())
}
