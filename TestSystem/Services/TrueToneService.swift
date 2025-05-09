//
//  TrueToneService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//

import Foundation

class TrueToneTestService {
    func saveResult(passed: Bool, to viewModel: TestOverviewViewModel) {
        let result = TestResult(
            testType: .trueTone,
            passed: passed,
            timestamp: Date(),
            notes: passed ? nil : "User did not confirm True Tone",
            confirmed: true
        )
        viewModel.addResult(result)
    }
}
