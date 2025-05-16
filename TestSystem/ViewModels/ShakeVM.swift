//
//  ShakeMV.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//
//  Monitors device motion using Core Motion to detect shake events.
//  Publishes shake detection to SwiftUI views.
//

import Foundation
import CoreMotion

class ShakeTestViewModel: ObservableObject {
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()

    @Published var shakeDetected: Bool = false
    private let shakeThreshold: Double = 2.5

    init() {
        start()
    }

    deinit {
        stop()
    }

    func start() {
        guard motionManager.isAccelerometerAvailable else { return }

        motionManager.accelerometerUpdateInterval = 1.0 / 60.0

        motionManager.startAccelerometerUpdates(to: queue) { [weak self] data, _ in
            guard let self = self, let acc = data?.acceleration else { return }

            let magnitude = sqrt(acc.x*acc.x + acc.y*acc.y + acc.z*acc.z)

            if magnitude > self.shakeThreshold {
                DispatchQueue.main.async {
                    guard self.shakeDetected == false else { return }

                    self.shakeDetected = true

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.shakeDetected = false
                    }
                }
            }
        }
    }

    func stop() {
        motionManager.stopAccelerometerUpdates()
    }

    func saveResult(passed: Bool, to overviewVM: TestOverviewViewModel) {
        let result = TestResult(
            testType: .shake,
            passed: passed,
            timestamp: Date(),
            notes: passed ? nil : "Shake not detected",
            confirmed: true
        )
        overviewVM.addResult(result)
    }
}
