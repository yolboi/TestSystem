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

    @State private var testPassed: Bool? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("Touch firmly on the button below")
                .font(.title)

            DefaultButton(title: "Haptic Feedback test") {
                testPassed = false // Hvis man bare trykker, er det ikke nok
            }
            .contextMenu {
                Button("Tap to pass the test") {
                    testPassed = true
                    saveResultAndContinue()
                }
            }

            if testPassed == false {
                FailedTest(showFailed: true)
            } else if testPassed == true {
                Text("Passed")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }

    private func saveResultAndContinue() {
        let result = TestResult(
            testType: .threeD,
            passed: true,
            timestamp: Date(),
            notes: nil,
            confirmed: true
        )

        testOverviewVM.addResult(result)

        // Navigér videre hvis i fullScreen flow
        onComplete()
    }
}

#Preview {
    ThreeDtouchTestView()
}
