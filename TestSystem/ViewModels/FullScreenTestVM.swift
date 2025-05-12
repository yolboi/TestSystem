//
//  FullTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//
//  Manages the multi-step screen testing flow by tracking the
//  current step and providing navigation logic for moving through
//  all screen test stages.
//

import SwiftUI

class FullScreenTestViewModel: ObservableObject {
    @Published var currentStepIndex = 0 ///the step the user is currently on during the full screen test
    @Published var isInFullScreenTest: Bool = true /// the user is indeed inside the fullscreentest

    ///Returns all possible screen test steps
    var steps: [ScreenTestStep] {
        ScreenTestStep.allCases
    }

    ///the current screen test step based on currentStepIndex
    var currentStep: ScreenTestStep {
        steps[currentStepIndex]
    }

    ///Moves to the next screen test step by incrementing currentStepIndex... does not exceed the number of available steps
    func goToNextStep() {
        if currentStepIndex < steps.count - 1 {
            currentStepIndex += 1
        }
    }
}
