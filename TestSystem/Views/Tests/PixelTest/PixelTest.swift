//
//  PixelTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//
// Main pixel view handling the pixel test process and flow including start instructions,
// color cycling during the test, error marking, and saving the result.
//

import SwiftUI

struct PixelTestView: View {
    @EnvironmentObject var navModel: NavigationModel /// Navigation model to control app flow
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel /// Test result storage and overview

    @State private var started = false  /// Tracks if the test has started
    @StateObject private var vm: PixelTestViewModel /// ViewModel for managing pixel test state

    var onComplete: () -> Void  /// Callback triggered when test is completed

    init(testOverviewVM: TestOverviewViewModel, onComplete: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: PixelTestViewModel(testOverviewVM: testOverviewVM))
        self.onComplete = onComplete
    }

    var body: some View {
        VStack {
            if started {
                /// Pixel test active view
                PixelTestScreen(viewModel: vm)

                VStack(spacing: 12) {
                    /// Result feedback text
                    if vm.testPassed {
                        Text("No pixel errors detected.")
                            .foregroundColor(.green)
                            .font(.headline)
                    } else {
                        Text("Pixel errors detected.")
                            .foregroundColor(.red)
                            .font(.headline)
                    }

                    /// Done button to finish and save result
                    DefaultButton(title: "Done") {
                        vm.finishTest()
                        onComplete() /// Call the provided completion handler
                    }
                    .padding(.top)
                }
                .padding()
            } else {
                /// Start screen before test begins
                VStack(spacing: 20) {
                    Text("Pixel Test")
                        .font(.largeTitle)
                        .bold()

                    Text("Swipe with two fingers to iterate through different colors.\nMark pixel errors by tapping on the screen with one finger.\n\nMake sure there are no stuck or dead pixels.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()

                    Spacer()

                    /// Button to start the test
                    DefaultButton(title: "Start Test") {
                        started = true
                    }
                    .padding()
                }
                .padding()
            }
        }
        .navigationTitle("Pixel Test")
        .navigationBarTitleDisplayMode(.inline)
    }
}
