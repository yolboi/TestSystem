//
//  CameraVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//

import Foundation
import SwiftUI

class CameraTestViewModel: ObservableObject {
    enum CameraLens: String, CaseIterable {
        case ultraWide = "Ultra Wide"
        case wide = "Wide"
        case telephoto = "Telephoto"
    }

    @Published var capturedImages: [CameraLens: UIImage] = [:]
    let lensOrder: [CameraLens] = [.ultraWide, .wide, .telephoto]
    @Published var currentLensIndex: Int = 0

    private var testOverviewVM: TestOverviewViewModel
    private let cameraService = CameraService()

    var testCompleted: Bool {
        capturedImages.count == lensOrder.count
    }

    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
    }

    func capture(image: UIImage) {
        guard currentLensIndex < lensOrder.count else { return }
        let currentLens = lensOrder[currentLensIndex]
        capturedImages[currentLens] = image
        currentLensIndex += 1
    }

    func finishTest() {
        cameraService.saveResult(capturedImages: capturedImages.values.map { $0 }, expectedCount: lensOrder.count, to: testOverviewVM)
    }

    var nextLensToCapture: CameraLens? {
        if currentLensIndex < lensOrder.count {
            return lensOrder[currentLensIndex]
        } else {
            return nil
        }
    }
}
