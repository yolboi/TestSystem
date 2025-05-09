//
//  ThreeDTouchTestVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 09/05/2025.
//

import Foundation

class ThreeDTouchTestViewModel: ObservableObject {
    @Published var testPassed: Bool? = nil

    func passTest(using overviewVM: TestOverviewViewModel) {
        testPassed = true
        saveResult(passed: true, to: overviewVM)
    }

    func failTest(using overviewVM: TestOverviewViewModel) {
        testPassed = false
        saveResult(passed: false, to: overviewVM)
    }

    private func saveResult(passed: Bool, to overviewVM: TestOverviewViewModel) {
        let result = TestResult(
            testType: .threeD,
            passed: passed,
            timestamp: Date(),
            notes: passed ? nil : "User marked test as failed",
            confirmed: true
        )
        overviewVM.addResult(result)
    }
}
