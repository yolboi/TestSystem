//
//  CameraTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//

import SwiftUI

struct CameraTestView: View {
    @StateObject private var vm = CameraTestViewModel()
    @State private var showCamera = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            if vm.currentLensIndex < vm.lensOrder.count {
                Text("Take a picture using the: \(vm.lensOrder[vm.currentLensIndex])-lens")
                    .font(.headline)
            } else {
                Text("All lenses are tested")
                    .font(.headline)
            }
            
            SecondaryButton(title: "Take picture") {
                showCamera = true
            }
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(vm.capturedImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .padding()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            if vm.testCompleted {
                Text("All lenses are tested")
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
