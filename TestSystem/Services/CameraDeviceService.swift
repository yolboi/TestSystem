//
//  CameraDeviceService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//
//  CameraDeviceService is an utility service to detect available rear camera lenses
//  on the device using AVFoundation. Maps hardware devices to app-specific CameraLens types.
//

import AVFoundation

class CameraDeviceService {
    
    /// Returns a list of available CameraLens based on the device’s physical camera hardware. Not a 100% sure if it works, only tested with an iPhone 11 pro
    static func availableLenses() -> [CameraLens] {
        let discovery = AVCaptureDevice.DiscoverySession( ///find available cameras on the back of the device, filtering by video media type. looks for Ultra-Wide camera etc.
            deviceTypes: [
                .builtInUltraWideCamera,
                .builtInWideAngleCamera,
                .builtInTelephotoCamera
            ],
            mediaType: .video,
            position: .back
        )

        var availableLenses: [CameraLens] = [] /// store lens types available

        ///Loops over the discovered devices, matches device type to a corresponding case in CameraLens enum, adds lens to array
        for device in discovery.devices {
            switch device.deviceType {
            case .builtInUltraWideCamera:
                availableLenses.append(.ultraWide)
            case .builtInWideAngleCamera:
                availableLenses.append(.wide)
            case .builtInTelephotoCamera:
                availableLenses.append(.telephoto)
            default:
                break
            }
        }

        return availableLenses
    }
}
