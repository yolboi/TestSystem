//
//  TrueToneService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//
// Provides a service to save the results of the true tone test.
// Creates a TestResult and stores it.

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
