//
//  BetteryService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 01/05/2025.
//

import UIKit
import Foundation

class BatteryService: ObservableObject {
    @Published var batteryLevel: Float = UIDevice.current.batteryLevel
    @Published var batteryState: UIDevice.BatteryState = UIDevice.current.batteryState

    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
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

    @objc private func batteryLevelDidChange(_ notification: Notification) {
        batteryLevel = UIDevice.current.batteryLevel
    }

    @objc private func batteryStateDidChange(_ notification: Notification) {
        batteryState = UIDevice.current.batteryState
    }

    func getBatteryLevel() -> Float {
        return batteryLevel
    }

    func getBatteryState() -> String {
        switch batteryState {
        case .charging: return "Charging"
        case .full: return "Full"
        case .unplugged: return "Not Charging"
        case .unknown: return "Unknown"
        @unknown default: return "Unknown"
        }
    }
}
