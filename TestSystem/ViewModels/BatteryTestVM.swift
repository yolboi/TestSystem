//
//  BatteryTestVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 01/05/2025.
//
// Manages battery test logic, updates UI state, evaluates test outcome, and saves results to the TestOverviewViewModel.
//

import Foundation

class BatteryTestViewModel: ObservableObject {
    @Published var batteryLevelText: String = "" ///current battery level as a readable string (e.g., “Battery Level: 85%”)
    @Published var batteryStateText: String = "" ///current battery state (e.g., “Charging”, “Full”, “Not Charging”)
    @Published var testPassed: Bool = false

    private let batteryService = BatteryService()
    private var testOverviewVM: TestOverviewViewModel

    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
        updateBatteryStatus() // opdater UI, men gem IKKE noget
    }

    ///Updates batteryLevelText, batteryStateText, and testPassed based on the current battery status
    func updateBatteryStatus() {
        let level = batteryService.getBatteryLevel()
        let state = batteryService.getBatteryState()

        batteryLevelText = "Battery Level: \(Int(level * 100))%"
        batteryStateText = "Battery State: \(state)"
        testPassed = (state == "Charging" || state == "Full")
    }

    func finishTest() {
        updateBatteryStatus() ///refreshes the battery status

        let result = TestResult(
            testType: .battery,
            passed: testPassed,
            timestamp: Date(),
            notes: testPassed ? nil : "Telefonen blev ikke opladt",
            confirmed: true // <-- vigtigt!
        )
        print("Saving result: \(result)")
        testOverviewVM.addResult(result)
    }
}
