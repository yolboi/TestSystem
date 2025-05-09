//
//  Shake.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//

import SwiftUI

struct ShakeTestView: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel
    @EnvironmentObject var navModel: NavigationModel
    var fullScreenVM: FullScreenTestViewModel? = nil

    @StateObject private var viewModel = ShakeTestViewModel()
    private let shakeService = ShakeTestService()

    @State private var testCompleted = false
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Text(testCompleted ? "Test completed!" : "Shake the phone to test")
                .font(.title2)

            Image(systemName: viewModel.shakeDetected ? "hand.raised.fill" : "hand.raised")
                .font(.system(size: 60))
                .foregroundColor(viewModel.shakeDetected ? .green : .gray)

            if testCompleted {
                DefaultButton(title: "Finish Test") {
                    shakeService.saveResult(passed: true, to: testOverviewVM)
                    if let fullVM = fullScreenVM {
                        fullVM.goToNextStep()
                    } else {
                        navModel.path.removeLast()
                    }
                }
            } else {
                SecondaryButton(title: "Fail Test") {
                    shakeService.saveResult(passed: false, to: testOverviewVM)
                    navModel.path.removeLast()
                }
            }
        }
        .padding()
        .onReceive(viewModel.$shakeDetected) { didShake in
            if didShake {
                testCompleted = true
            }
        }
    }
}
