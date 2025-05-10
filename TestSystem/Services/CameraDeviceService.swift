//
//  CameraDeviceService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//

import AVFoundation

class CameraDeviceService {
    static func availableLenses() -> [CameraLens] {
        let discovery = AVCaptureDevice.DiscoverySession(
            deviceTypes: [
                .builtInUltraWideCamera,
                .builtInWideAngleCamera,
                .builtInTelephotoCamera
            ],
            mediaType: .video,
            position: .back
        )

        var availableLenses: [CameraLens] = []

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
