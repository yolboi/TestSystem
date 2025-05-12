//
//  AudioTestView.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 29/04/2025.
//
// View handling the speaker and earpiece audio test
//

import SwiftUI

struct EarpieceView: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel
    @EnvironmentObject var navModel: NavigationModel
    @StateObject private var vm = EarpieceTestVM()
    @State private var testMode = 0

    var body: some View {
        VStack(spacing: 20) {
            /// Status image based on current test phase
            Image(systemName: vm.statusImage)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 100)
                .padding(.top, 30)

            Spacer()

            Text("Speaker & Earpiece Test")
                .font(.headline)

            Spacer()
            
            /// Status text description
            Text(vm.statusText)
                .font(.headline)
                .padding()
            
            /// Button to start or continue the audio test
            DefaultButton(title: "Start Audiotest") {
                vm.runTestCycle(mode: testMode)
                testMode += 1
            }
            
            /// If test is completed, show End Test button
            if vm.testCompleted {
                Text("Test completed")
                    .foregroundColor(.green)

                SecondaryButton(title: "End Test") {
                    vm.finishTest(using: testOverviewVM) ///save result
                    navModel.goBack() /// Navigate back
                }
            } else {
                /// If test is not completed, show Stop Test button
                SecondaryButton(title: "Stop Test") {
                    vm.stopTest()
                    navModel.goBack()
                }
            }
        }
        .padding()
    }
}

#Preview {
    EarpieceView()
}
