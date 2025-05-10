//
//  CameraCaptureM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//

import SwiftUI

struct CapturedImage: Identifiable, Hashable {
    let id = UUID()
    let image: UIImage
    let lens: CameraLens

    static func == (lhs: CapturedImage, rhs: CapturedImage) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
