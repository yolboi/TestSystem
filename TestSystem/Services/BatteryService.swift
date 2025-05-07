//
//  BetteryService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 01/05/2025.
//

import UIKit
import Foundation
import UIDeviceListener

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

struct BatteryAdvancedInfo {
    let currentCapacity: Int
    let maxCapacity: Int
    let designCapacity: Int
    let cycleCount: Int
}

class BatteryInfoService {
    static func fetchBatteryAdvancedInfo() -> BatteryAdvancedInfo? {
        guard let listener = UIDeviceListener.shared else { return nil }

        let capacity = listener.query(key: .batteryRawCurrentCapacity) as? Int ?? -1
        let maxCapacity = listener.query(key: .batteryRawMaxCapacity) as? Int ?? -1
        let designCapacity = listener.query(key: .batteryDesignCapacity) as? Int ?? -1
        let cycles = listener.query(key: .batteryCycleCount) as? Int ?? -1

        return BatteryAdvancedInfo(
            currentCapacity: capacity,
            maxCapacity: maxCapacity,
            designCapacity: designCapacity,
            cycleCount: cycles
        )
    }
}
