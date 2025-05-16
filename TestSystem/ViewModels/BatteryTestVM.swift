//
//  BatteryTestVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 01/05/2025.
//
// Manages battery test logic, updates UI state, evaluates test outcome, and saves results to the TestOverviewViewModel.
//

import Foundation
import Combine

class BatteryTestViewModel: ObservableObject {
    @Published var batteryLevelText: String = ""      /// "Battery Level: 85%"
    @Published var batteryStateText: String = ""      /// "Battery State: Charging"
    @Published var testPassed: Bool = false           /// Used to determine if test should pass

    private let batteryService = BatteryService()
    private var testOverviewVM: TestOverviewViewModel /// Passed in via View
    private var cancellables = Set<AnyCancellable>()  /// Combine tokens

    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
        bindToBatteryService()
    }

    /// Subscribes to BatteryService updates
    private func bindToBatteryService() {
        batteryService.$batteryLevel
            .sink { [weak self] level in
                self?.batteryLevelText = "Battery Level: \(Int(level * 100))%"
            }
            .store(in: &cancellables)

        batteryService.$batteryState
            .sink { [weak self] state in
                let readable = self?.batteryService.getBatteryState() ?? "Unknown"
                self?.batteryStateText = "Battery State: \(readable)"
                self?.testPassed = (readable == "Charging" || readable == "Full")
            }
            .store(in: &cancellables)
    }

    func updateBatteryStatus() {
        let level = batteryService.getBatteryLevel()
        let state = batteryService.getBatteryState()

        batteryLevelText = "Battery Level: \(Int(level * 100))%"
        batteryStateText = "Battery State: \(state)"
        testPassed = (state == "Charging" || state == "Full")
    }

    /// Saves test result
    func finishTest() {
        let result = TestResult(
            testType: .battery,
            passed: testPassed,
            timestamp: Date(),
            notes: testPassed ? nil : "Telefonen blev ikke opladt",
            confirmed: true
        )
        print("Saving result: \(result)")
        testOverviewVM.addResult(result)
    }
}
