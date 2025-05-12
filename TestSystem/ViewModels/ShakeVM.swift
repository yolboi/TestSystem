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
    
    private let motionManager = CMMotionManager() /// Core Motion manager to access accelerometer data
    private let queue = OperationQueue() /// Background queue for motion updates
    
    /// True for a short moment when a shake is detected
    @Published var shakeDetected: Bool = false
    
    /// Threshold (in G-forces) to count as a shake
    private let shakeThreshold: Double = 2.5
    
    init() {
        start() /// Start accelerometer updates when ViewModel is initialized
    }
    
    deinit {
        stop() /// Stop updates when ViewModel is deallocated
    }
    
    /// Start accelerometer updates
    func start() {
        guard motionManager.isAccelerometerAvailable else { return }
        
        motionManager.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz update rate
        
        motionManager.startAccelerometerUpdates(to: queue) { [weak self] data, error in
            guard let self = self, let acc = data?.acceleration else { return }
            
            // Calculate the magnitude of acceleration
            let magnitude = sqrt(acc.x*acc.x + acc.y*acc.y + acc.z*acc.z)
            
            if magnitude > self.shakeThreshold {
                DispatchQueue.main.async {
                    // Avoid firing multiple times per second
                    guard self.shakeDetected == false else { return }
                    
                    self.shakeDetected = true
                    
                    // Reset after 0.5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.shakeDetected = false
                    }
                }
            }
        }
    }
    
    /// Stop accelerometer updates
    func stop() {
        motionManager.stopAccelerometerUpdates()
    }
}
