//
//  CameraTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//
//  Guides users through a step-by-step camera lens test, prompting them to capture one photo per available lens,
//  and displaying captured images.
//
import SwiftUI

struct CameraTestView: View {
    
    @EnvironmentObject var navModel: NavigationModel /// Access to navigation model for screen transitions
    @StateObject private var vm: CameraTestViewModel /// ViewModel managing camera test logic
    @State private var showCamera = false /// Controls when the camera view is shown
    
    init(testOverviewVM: TestOverviewViewModel) {
        _vm = StateObject(wrappedValue: CameraTestViewModel(testOverviewVM: testOverviewVM))
    }

    var body: some View {
        VStack(spacing: 20) {
            /// Title and description
            Text("Camera Lens Test")
                .font(.title)
                .bold()

            Text("Take one picture with each available lens. You must take photos with UltraWide, Wide, and Telephoto cameras (if available).")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Divider()

            /// Camera test progress section
            if let nextLens = vm.nextLensToCapture {
                Text("Next: Capture a photo with the \(nextLens.rawValue) lens")
                    .font(.headline)

                /// Button to open camera and take a photo
                SecondaryButton(title: "Take Picture") {
                    showCamera = true
                }
            } else {
                /// Message when all lenses are tested
                Text("All lenses have been tested!")
                    .font(.headline)
                    .foregroundColor(.green)

                /// Button to finish the test and go back
                DefaultButton(title: "Finish Test") {
                    vm.finishTest()
                    navModel.path.removeLast()
                }
            }

            Divider()

            /// Display captured images
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
        /// Present camera when needed
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
