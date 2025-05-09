//
//  ShakeService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//

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
