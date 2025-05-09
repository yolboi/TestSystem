//
//  TouchTestService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 07/05/2025.
//

import Foundation
import UIKit

class TouchTestService {
    func saveResult(passed: Bool, to viewModel: TestOverviewViewModel) {
        let result = TestResult(
            testType: .screen,
            passed: passed,
            timestamp: Date(),
            notes: passed ? nil : "Not all squares were touched",
            confirmed: true
        )
        viewModel.addResult(result)
    }
}
