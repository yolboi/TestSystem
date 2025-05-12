//
//  PixelService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//
//  Provides a service to save the results of the pixel test.
//  Creates a TestResult and stores it.

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
