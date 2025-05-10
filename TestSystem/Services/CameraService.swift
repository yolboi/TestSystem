//
//  CameraService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//

import UIKit

class CameraService {
    func isTestPassed(capturedImages: [UIImage], expectedCount: Int) -> Bool {
        return capturedImages.count >= expectedCount
    }

    func saveResult(capturedImages: [UIImage], expectedCount: Int, to viewModel: TestOverviewViewModel) {
        let passed = isTestPassed(capturedImages: capturedImages, expectedCount: expectedCount)
        let result = TestResult(
            testType: .camera,
            passed: passed,
            timestamp: Date(),
            notes: passed ? nil : "Not all camera lenses were tested",
            confirmed: true
        )
        viewModel.addResult(result)
    }
}
