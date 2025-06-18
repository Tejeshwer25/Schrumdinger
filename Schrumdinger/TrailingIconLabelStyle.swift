//
//  TrailingIconLabelStyle.swift
//  Schrumdinger
//
//  Created by Tejeshwer Singh on 18/06/25.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    
    /// System calls this method for each `Label` instance in a view hierarchy where this style is the current label style
    /// - Parameter configuration: The configuration parameter is a LabelStyleConfiguration, which contains the icon and title views. These views represent the label’s image and text.
    /// - Returns: Label view
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}
