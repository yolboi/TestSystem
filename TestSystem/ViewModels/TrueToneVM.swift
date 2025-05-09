//
//  TrueToneMV.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//

import Foundation
import Combine

class TrueToneViewModel: ObservableObject {
    @Published var confirmed: Bool = false
    private let testService = TrueToneTestService()
    private let testOverviewVM: TestOverviewViewModel

    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
    }

    func didConfirm() {
        confirmed = true
        saveResult()
    }

    private func saveResult() {
        testService.saveResult(passed: confirmed, to: testOverviewVM)
    }
}
