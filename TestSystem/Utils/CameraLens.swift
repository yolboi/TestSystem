//
//  CameraLens.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//
// Defines an enum representing different camera lens types.
// Provides a mapping to the physical camera position used for capture.
//

import AVFoundation

enum CameraLens: String, CaseIterable {
    case ultraWide = "UltraWide"
    case wide = "Wide"
    case telephoto = "Telephoto"

    /// Which camera position should be used (all on the back of an iPhone)
    var capturePosition: AVCaptureDevice.Position {
        return .back
    }
}
