//
//  PixelService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//

import Foundation

class PixelTestService {
    func saveResult(passed: Bool, to viewModel: TestOverviewViewModel) {
        let result = TestResult(
            testType: .pixel,
            passed: passed,
            timestamp: Date(),
            notes: passed ? nil : "Pixel errors were detected",
            confirmed: true
        )
        viewModel.addResult(result)
    }
}
