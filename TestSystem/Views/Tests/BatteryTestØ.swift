//
//  BatteryTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 29/04/2025.
//

import SwiftUI

struct BatteryTestView: View {
    @StateObject private var viewModel: BatteryTestViewModel
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel
    @Environment(\.dismiss) var dismiss

    init(testOverviewVM: TestOverviewViewModel) {
        _viewModel = StateObject(wrappedValue: BatteryTestViewModel(testOverviewVM: testOverviewVM))
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Battery Test")
                .font(.title)
                .padding(.top)

            Text(viewModel.batteryLevelText)
                .font(.headline)

            Text(viewModel.batteryStateText)
                .font(.subheadline)

            Divider()

            if viewModel.testPassed {
                Text("Test bestået")
                    .foregroundColor(.green)
            } else {
                Text("Sæt venligst opladning til")
                    .foregroundColor(.red)
            }

            Spacer()

            Button("Opdater status") {
                viewModel.updateBatteryStatus()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Spacer()
            
            SecondaryButton(title: "Afslut test") {
                viewModel.finishTest()
                dismiss()
            }
        }
        .padding()
    }
}
