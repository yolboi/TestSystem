//
//  TrueTone.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//

import SwiftUI

struct TrueToneView: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel
    @EnvironmentObject var navModel: NavigationModel
    var onComplete: () -> Void = {}

    @StateObject private var viewModel: TrueToneViewModel

    init(onComplete: @escaping () -> Void = {}) {
        self.onComplete = onComplete
        _viewModel = StateObject(wrappedValue: TrueToneViewModel(testOverviewVM: TestOverviewViewModel()))
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("Høj sandsynlighed for, at skærmen har True Tone")
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

            Text("Swipe ned fra øverste højre hjørne for at åbne Kontrolcenter og bekræft True Tone.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Toggle("Jeg har bekræftet True Tone i Kontrolcenter", isOn: $viewModel.confirmed)
                .padding(.horizontal)

            Button(action: {
                viewModel.didConfirm()
                onComplete()
            }) {
                Text("Fortsæt")
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
