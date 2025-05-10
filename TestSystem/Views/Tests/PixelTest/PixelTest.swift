//
//  PixelTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//

import SwiftUI

struct PixelTestView: View {
    @EnvironmentObject var navModel: NavigationModel
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel

    @State private var started = false
    @StateObject private var vm: PixelTestViewModel

    var onComplete: () -> Void

    init(testOverviewVM: TestOverviewViewModel, onComplete: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: PixelTestViewModel(testOverviewVM: testOverviewVM))
        self.onComplete = onComplete
    }

    var body: some View {
        VStack {
            if started {
                PixelTestScreen(viewModel: vm)

                VStack(spacing: 12) {
                    if vm.testPassed {
                        Text("No pixel errors detected.")
                            .foregroundColor(.green)
                            .font(.headline)
                    } else {
                        Text("Pixel errors detected.")
                            .foregroundColor(.red)
                            .font(.headline)
                    }

                    DefaultButton(title: "Done") {
                        vm.finishTest()
                        onComplete() // Brug den her i stedet for navModel direkte
                    }
                    .padding(.top)
                }
                .padding()
            } else {
                VStack(spacing: 20) {
                    Text("Pixel Test")
                        .font(.largeTitle)
                        .bold()

                    Text("Swipe with two fingers to iterate through different colors.\nMark pixel errors by tapping on the screen with one finger.\n\nMake sure there are no stuck or dead pixels.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()

                    Spacer()

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
