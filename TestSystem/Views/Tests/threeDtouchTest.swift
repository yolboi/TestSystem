//
//  3DtouchTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 27/03/2025.
//

import SwiftUI

struct ThreeDtouchTestView: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel
    @EnvironmentObject var navModel: NavigationModel

    var onComplete: () -> Void = {}

    @StateObject private var viewModel = ThreeDTouchTestViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Touch firmly on the button below")
                .font(.title)

            DefaultButton(title: "Haptic Feedback test") {
                viewModel.markAsFailed(using: testOverviewVM)
            }
            .contextMenu {
                Button("Tap to pass the test") {
                    viewModel.markAsPassed(using: testOverviewVM, onComplete: onComplete)
                }
            }

            if viewModel.testPassed == false {
                FailedTest(showFailed: true)
            } else if viewModel.testPassed == true {
                Text("Passed")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }
}

#Preview {
    ThreeDtouchTestView()
}
