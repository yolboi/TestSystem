//
//  ThreeDTouchTestVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 09/05/2025.
//
//  Manages the 3D Touch or Haptic Touch test, allowing users to mark the test as passed or failed,
//  and saves results.
//

import Foundation

class ThreeDTouchTestViewModel: ObservableObject {

    @Published var testPassed: Bool? = nil /// Tracks if the user passed or failed the test (initially nil)

    /// Marks the test as passed and saves the result
    func markAsPassed(using overviewVM: TestOverviewViewModel, onComplete: @escaping () -> Void) {
        testPassed = true
        saveResult(passed: true, to: overviewVM)
        onComplete()
    }

    ///Marks the test as failed and saves the result
    func markAsFailed(using overviewVM: TestOverviewViewModel) {
        testPassed = false
        saveResult(passed: false, to: overviewVM)
    }

    /// Creates and saves a TestResult for the 3D Touch test
    private func saveResult(passed: Bool, to overviewVM: TestOverviewViewModel) {
        let result = TestResult(
            testType: .threeD,
            passed: passed,
            timestamp: Date(),
            notes: passed ? nil : "User marked test as failed", // Adds a failure note if necessary
            confirmed: true
        )
        overviewVM.addResult(result)
    }
}
