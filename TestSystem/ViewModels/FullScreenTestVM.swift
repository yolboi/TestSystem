//
//  FullTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//

import SwiftUI

class FullScreenTestViewModel: ObservableObject {
    @Published var currentStepIndex = 0
    @Published var isInFullScreenTest: Bool = true

    var steps: [ScreenTestStep] {
        ScreenTestStep.allCases
    }

    var currentStep: ScreenTestStep {
        steps[currentStepIndex]
    }

    func goToNextStep() {
        if currentStepIndex < steps.count - 1 {
            currentStepIndex += 1
        }
    }
}
