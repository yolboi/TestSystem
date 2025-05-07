//
//  CameraTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//

import SwiftUI

struct CameraTestView: View {
    @StateObject private var vm: CameraTestViewModel
    @State private var showCamera = false
    
    init(testOverviewVM: TestOverviewViewModel) {
        _vm = StateObject(wrappedValue: CameraTestViewModel(testOverviewVM: testOverviewVM))
    }

    
    var body: some View {
        VStack(spacing: 20) {
            if !vm.testCompleted {
                Text("Take a picture with: \(vm.lensOrder[vm.currentLensIndex].rawValue)-lens")

                SecondaryButton(title: "Take picture") {
                    showCamera = true
                }
            } else {
                Text("All lenses are tested")
                    .font(.headline)
                    .foregroundColor(.green)

                SecondaryButton(title: "End Test") {
                    vm.finishTest()
                }
            }
            
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(vm.capturedImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            
            if vm.testCompleted {
                Text("All pictures is captured")
                    .foregroundColor(.green)
                    .font(.title3)

                DefaultButton(title: "End test") {
                    vm.finishTest()
                }
            }
        }
        .sheet(isPresented: $showCamera) {
            CameraCaptureView { image in
                if let img = image {
                    vm.capture(image: img)
                }
                showCamera = false
            }
        }
    }
}
