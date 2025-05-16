//
//  TrueToneMV.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//

import Foundation
import UIKit

class TrueToneViewModel: ObservableObject {
    @Published var confirmed: Bool = false

    private let testOverviewVM: TestOverviewViewModel

    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
    }

    /// Gemmer testresultatet
    func saveResultAndContinue(onComplete: () -> Void) {
        let result = TestResult(
            testType: .trueTone,
            passed: confirmed,
            timestamp: Date(),
            notes: confirmed ? nil : "User did not confirm True Tone",
            confirmed: true
        )
        testOverviewVM.addResult(result)
        onComplete()
    }

    /// Tjekker om skærmen rapporterer understøttelse af P3 (bredt farverum)
    var supportsWideColor: Bool {
        UIScreen.main.traitCollection.displayGamut == .P3
    }
}
