//
//  TrueToneMV.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//

import Foundation
import Combine

class TrueToneViewModel: ObservableObject {
    @Published var confirmed: Bool = false /// Tracks if the user confirmed that True Tone is working
    
    private let testService = TrueToneTestService() /// Service responsible for saving the True Tone test result
    private let testOverviewVM: TestOverviewViewModel /// ViewModel that collects all test results
    
    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
    }

    /// Called when the user confirms that True Tone is working
    func didConfirm() {
        confirmed = true
        saveResult()
    }

    /// Saves the test result to the TestOverviewViewModel
    private func saveResult() {
        testService.saveResult(passed: confirmed, to: testOverviewVM)
    }
}
