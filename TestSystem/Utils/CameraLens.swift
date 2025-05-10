//
//  CameraLens.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//

import AVFoundation

enum CameraLens: String, CaseIterable {
    case ultraWide = "UltraWide"
    case wide = "Wide"
    case telephoto = "Telephoto"

    /// Hvilket kamera-position skal bruges (alle bag på en iPhone)
    var capturePosition: AVCaptureDevice.Position {
        return .back
    }
}
