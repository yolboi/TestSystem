//
//  DeviceService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 04/05/2025.
//

import UIKit

class DeviceInfoService {
    static func modelIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        return withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(cString: $0)
            }
        }
    }

    static func readableModelName() -> String {
        let identifier = modelIdentifier()

        let deviceMap: [String: String] = [
            "iPhone15,2": "iPhone 14 Pro",
            "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone14,5": "iPhone 13",
            // Tilføj flere efter behov
        ]

        return deviceMap[identifier] ?? identifier
    }
}
