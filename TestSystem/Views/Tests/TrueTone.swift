//
//  TrueTone.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//

import SwiftUI

struct TrueToneView: View {
    @EnvironmentObject var navModel: NavigationModel
    var onComplete: () -> Void = {}

    @StateObject private var viewModel: TrueToneViewModel

    init(testOverviewVM: TestOverviewViewModel, onComplete: @escaping () -> Void = {}) {
        self.onComplete = onComplete
        _viewModel = StateObject(wrappedValue: TrueToneViewModel(testOverviewVM: testOverviewVM))
    }

    var body: some View {
        VStack(spacing: 24) {
            Text(viewModel.supportsWideColor
                 ? "This screen supports wide color (P3). True Tone is likely available."
                 : "This screen does not support wide color (P3). True Tone may be unavailable.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 200)
                    .cornerRadius(12)
                Image(systemName: "arrow.up")
                    .font(.system(size: 40))
                    .padding()
            }
            .padding(.horizontal)

            Text("Swipe down from the top right corner to open Control Center and confirm True Tone")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Toggle("I have confirmed True Tone in Control Center", isOn: $viewModel.confirmed)
                .padding(.horizontal)

            Button(action: {
                viewModel.saveResultAndContinue(onComplete: onComplete)
            }) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.confirmed ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(!viewModel.confirmed)
            .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("True Tone Test")
        .padding()
    }
}
