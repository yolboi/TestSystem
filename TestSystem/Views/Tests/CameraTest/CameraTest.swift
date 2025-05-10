//
//  CameraTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//

import SwiftUI

struct CameraTestView: View {
    @EnvironmentObject var navModel: NavigationModel

    @StateObject private var vm: CameraTestViewModel
    @State private var showCamera = false
    @State private var showAlert = false

    init(testOverviewVM: TestOverviewViewModel) {
        _vm = StateObject(wrappedValue: CameraTestViewModel(testOverviewVM: testOverviewVM))
    }

    var body: some View {
        VStack(spacing: 20) {
            if let nextLens = vm.nextLensToCapture {
                Text("Take a picture with the \(nextLens.rawValue) lens")
                    .font(.headline)

                SecondaryButton(title: "Take Picture") {
                    showCamera = true
                }
            } else {
                Text("All lenses are tested")
                    .font(.headline)
                    .foregroundColor(.green)

                DefaultButton(title: "Finish Test") {
                    vm.finishTest()
                    navModel.path.removeLast()
                }
            }

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(vm.capturedImages.values.map { $0 }, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }
        .padding()
        .sheet(isPresented: $showCamera) {
            CameraCaptureView { image in
                if let img = image {
                    vm.capture(image: img)
                } else {
                    // Hvis brugeren lukker kamera uden at tage billede
                    showAlert = true
                }
                showCamera = false
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("No photo captured"),
                message: Text("Please take a picture to continue the test."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
