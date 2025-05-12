//
//  BetteryService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 01/05/2025.
//
//  Defines a service for monitoring battery level and charging status.
//  Publishes changes using ObservableObject for real-time updates
//  in the UI. Integrates with UIDevice and NotificationCenter.
//

import UIKit
import Foundation

class BatteryService: ObservableObject {
    @Published var batteryLevel: Float = UIDevice.current.batteryLevel ///battery percentage (0.0 - 1.0)
    @Published var batteryState: UIDevice.BatteryState = UIDevice.current.batteryState ///charging state

    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true /// Enables battery monitoring
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryLevelDidChange),
            name: UIDevice.batteryLevelDidChangeNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryStateDidChange),
            name: UIDevice.batteryStateDidChangeNotification,
            object: nil
        )
    }

    ///updates the battery level property
    @objc private func batteryLevelDidChange(_ notification: Notification) {
        batteryLevel = UIDevice.current.batteryLevel
    }

    /// updates battery state
    @objc private func batteryStateDidChange(_ notification: Notification) {
        batteryState = UIDevice.current.batteryState
    }

    /// return level as a float...
    func getBatteryLevel() -> Float {
        return batteryLevel
    }

    /// returns the state as an understandable sting
    func getBatteryState() -> String {
        switch batteryState {
        case .charging: return "Charging"
        case .full: return "Full"
        case .unplugged: return "Not Charging"
        case .unknown: return "Unknown"
        @unknown default: return "Unknown" ///just in case apple adds new states
        }
    }
}
