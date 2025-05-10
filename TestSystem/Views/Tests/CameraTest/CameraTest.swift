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

    init(testOverviewVM: TestOverviewViewModel) {
        _vm = StateObject(wrappedValue: CameraTestViewModel(testOverviewVM: testOverviewVM))
    }

    var body: some View {
        VStack(spacing: 20) {
            // Forklaringstekst
            Text("Camera Lens Test")
                .font(.title)
                .bold()

            Text("Take one picture with each available lens. You must take photos with UltraWide, Wide, and Telephoto cameras (if available).")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Divider()

            // Kamera progress
            if let nextLens = vm.nextLensToCapture {
                Text("Next: Capture a photo with the \(nextLens.rawValue) lens")
                    .font(.headline)

                SecondaryButton(title: "Take Picture") {
                    showCamera = true
                }
            } else {
                Text("All lenses have been tested!")
                    .font(.headline)
                    .foregroundColor(.green)

                DefaultButton(title: "Finish Test") {
                    vm.finishTest()
                    navModel.path.removeLast()
                }
            }

            Divider()

            // Billeder eller placeholdere
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(vm.capturedImagesArray) { capturedImage in
                    VStack {
                        Image(uiImage: capturedImage.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(10)

                        Text(capturedImage.lens.rawValue)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }

            Spacer()
        }
        .padding()
        .sheet(isPresented: $showCamera) {
            if let nextLens = vm.nextLensToCapture {
                CameraCaptureView(desiredLens: nextLens) { image in
                    if let img = image {
                        vm.service.capturedImage = img
                        vm.saveCapturedImage()
                    }
                    showCamera = false
                }
            }
        }
    }
}
