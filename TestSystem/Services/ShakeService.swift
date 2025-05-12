//
//  ShakeService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//
// Provides a service to save the results of the shake test.
// Creates a TestResult and stores it.

import Foundation

class ShakeTestService {
    func saveResult(passed: Bool, to viewModel: TestOverviewViewModel) {
        let result = TestResult(
            testType: .shake,
            passed: passed,
            timestamp: Date(),
            notes: passed ? nil : "Shake not detected",
            confirmed: true
        )
        viewModel.addResult(result)
    }
}
