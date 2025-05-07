//
//  AudioTestView.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 29/04/2025.
//
import SwiftUI

struct EarpieceView: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel
    @EnvironmentObject var navModel: NavigationModel
    @StateObject private var vm = EarpieceTestVM()
    @State private var testMode = 0

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: vm.statusImage)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 100)
                .padding(.top, 30)

            Spacer()

            Text("Speaker & Earpiece Test")
                .font(.headline)

            Spacer()

            Text(vm.statusText)
                .font(.headline)
                .padding()

            DefaultButton(title: "Start Audiotest") {
                vm.runTestCycle(mode: testMode)
                testMode += 1
            }

            if vm.testCompleted {
                Text("Test completed")
                    .foregroundColor(.green)

                SecondaryButton(title: "End Test") {
                    vm.finishTest(using: testOverviewVM)
                    navModel.goBack()
                }
            } else {
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
