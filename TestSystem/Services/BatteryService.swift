//
//  BetteryService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 01/05/2025.
//

import UIKit

class BatteryService {
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }

    func getBatteryLevel() -> Float {
        UIDevice.current.batteryLevel
    }

    func getBatteryState() -> String {
        switch UIDevice.current.batteryState {
        case .charging: return "Charging"
        case .full: return "Full"
        case .unplugged: return "Not Charging"
        case .unknown: return "Unknown"
        @unknown default: return "Unknown"
        }
    }
}
