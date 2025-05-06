//
//  CameraVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//

import SwiftUI

class CameraTestViewModel: ObservableObject {
    @Published var currentLensIndex = 0
    @Published var capturedImages: [UIImage] = []
    
    let lensOrder = ["Wide", "UltraWide", "Telephoto"]

    var testCompleted: Bool {
        capturedImages.count == lensOrder.count
    }

    func capture(image: UIImage) {
        capturedImages.append(image)
        currentLensIndex += 1
    }
}
