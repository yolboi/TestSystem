//
//  ShakeMV.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//

import Foundation
import CoreMotion

/// ObservableObject der publiserer et shake-event
class ShakeTestViewModel: ObservableObject {
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()
    
    /// True i et kort øjeblik når der registreres en shake
    @Published var shakeDetected: Bool = false
    
    /// Threshold (i G-krafter) for hvornår det tæller som et shake
    private let shakeThreshold: Double = 2.5
    
    init() {
        start()
    }
    
    deinit {
        stop()
    }
    
    /// Start accelerometer-opdateringer
    func start() {
        guard motionManager.isAccelerometerAvailable else { return }
        motionManager.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
        motionManager.startAccelerometerUpdates(to: queue) { [weak self] data, error in
            guard let self = self, let acc = data?.acceleration else { return }
            let magnitude = sqrt(acc.x*acc.x + acc.y*acc.y + acc.z*acc.z)
            if magnitude > self.shakeThreshold {
                DispatchQueue.main.async {
                    // Undgå at fyre flere gange i sekundet
                    guard self.shakeDetected == false else { return }
                    self.shakeDetected = true
                    // Resette efter fx 0.5 sek.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.shakeDetected = false
                    }
                }
            }
        }
    }
    
    /// Stop accelerometer-opdateringer
    func stop() {
        motionManager.stopAccelerometerUpdates()
    }
}
