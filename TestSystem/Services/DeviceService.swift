//
//  DeviceService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 04/05/2025.
//
// Just gets device info and converts iphone models into readable strings 

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

               // iPhone 8, 8 Plus & X
               "iPhone10,1": "iPhone 8",
               "iPhone10,2": "iPhone 8 Plus",
               "iPhone10,3": "iPhone X",
               "iPhone10,4": "iPhone 8",
               "iPhone10,5": "iPhone 8 Plus",
               "iPhone10,6": "iPhone X",

               // iPhone XS, XS Max & XR
               "iPhone11,2": "iPhone XS",
               "iPhone11,4": "iPhone XS Max",
               "iPhone11,6": "iPhone XS Max",
               "iPhone11,8": "iPhone XR",

               // iPhone 11 serie
               "iPhone12,1": "iPhone 11",
               "iPhone12,3": "iPhone 11 Pro",
               "iPhone12,5": "iPhone 11 Pro Max",
               "iPhone12,8": "iPhone SE (2nd Gen)",

               // iPhone 12 serie
               "iPhone13,1": "iPhone 12 mini",
               "iPhone13,2": "iPhone 12",
               "iPhone13,3": "iPhone 12 Pro",
               "iPhone13,4": "iPhone 12 Pro Max",

               // iPhone 13 serie
               "iPhone14,2": "iPhone 13 Pro",
               "iPhone14,3": "iPhone 13 Pro Max",
               "iPhone14,4": "iPhone 13 mini",
               "iPhone14,5": "iPhone 13",
               "iPhone14,6": "iPhone SE (3rd Gen)",

               // iPhone 14 serie
               "iPhone14,7": "iPhone 14",
               "iPhone14,8": "iPhone 14 Plus",
               "iPhone15,2": "iPhone 14 Pro",
               "iPhone15,3": "iPhone 14 Pro Max",

               // iPhone 15 serie
               "iPhone15,4": "iPhone 15",
               "iPhone15,5": "iPhone 15 Plus",
               "iPhone16,1": "iPhone 15 Pro",
               "iPhone16,2": "iPhone 15 Pro Max",

               // iPhone 16 serie
               "iPhone17,1": "iPhone 16 Pro",
               "iPhone17,2": "iPhone 16 Pro Max",
               "iPhone17,3": "iPhone 16",
               "iPhone17,4": "iPhone 16 Plus",
               "iPhone17,5": "iPhone 16e"
        ]

        return deviceMap[identifier] ?? identifier
    }
}
