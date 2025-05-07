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
        case wide = "Vidvinkel"
        case ultraWide = "Ultravidvinkel"
        case telephoto = "Telefoto"
    }

    @Published var capturedImages: [UIImage] = []
    let lensOrder: [CameraLens] = CameraLens.allCases
    @Published var currentLensIndex: Int = 0

    private var testOverviewVM: TestOverviewViewModel

    var testCompleted: Bool {
        capturedImages.count == lensOrder.count
    }

    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
    }

    func capture(image: UIImage) {
        guard capturedImages.count < lensOrder.count else { return }
        capturedImages.append(image)
        currentLensIndex += 1
    }

    func finishTest() {
        let result = TestResult(
            testType: .camera,
            passed: testCompleted,
            timestamp: Date(),
            notes: testCompleted ? nil : "Ikke alle billeder blev taget",
            confirmed: true
        )
        testOverviewVM.addResult(result)
    }
}
