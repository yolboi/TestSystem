//
//  TestEnd.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 03/05/2025.
//
// Simple view to display a completion screen after fullscreentest is done
//

import SwiftUI

struct TestCompletionView: View {
    let title: String /// Title text shown at the top
    let message: String  /// Message body shown under the title
    let buttonText: String  /// Text for the action button

    @EnvironmentObject var navModel: NavigationModel /// Access to navigation model to go back

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text(title)
                .font(.largeTitle)
                .bold()

            // Message
            Text(message)
                .font(.title3)

            // Continue Button
            DefaultButton(title: buttonText) {
                navModel.path.removeLast() /// Pops the last view from the navigation path
            }
        }
        .padding()
    }
}
