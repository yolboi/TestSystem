//
//  BatteryTestVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 01/05/2025.
//

import Foundation

class BatteryTestViewModel: ObservableObject {
    @Published var batteryLevelText: String = ""
    @Published var batteryStateText: String = ""
    @Published var testPassed: Bool = false

    private let batteryService = BatteryService()
    private var testOverviewVM: TestOverviewViewModel

    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
        updateBatteryStatus() // opdater UI, men gem IKKE noget
    }

    func updateBatteryStatus() {
        let level = batteryService.getBatteryLevel()
        let state = batteryService.getBatteryState()

        batteryLevelText = "Battery Level: \(Int(level * 100))%"
        batteryStateText = "Battery State: \(state)"
        testPassed = (state == "Charging" || state == "Full")
    }

    func finishTest() {
        updateBatteryStatus()

        let result = TestResult(
            testType: .battery,
            passed: testPassed,
            timestamp: Date(),
            notes: testPassed ? nil : "Telefonen blev ikke opladt",
            confirmed: true // <-- vigtigt!
        )
        print("Saving result:", result)
        testOverviewVM.addResult(result)
    }
}
