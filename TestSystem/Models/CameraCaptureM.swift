//
//  CameraCaptureM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//
// CapturedImage is used to represent photos taken during camera test.
// It holds information about the image, the camera lens used, and
// ensures that images can be uniquely identified, compared, and handled.


import SwiftUI

struct CapturedImage: Identifiable, Hashable {
    let id = UUID() ///Each CapturedImage instance gets a unique identifier when created
    let image: UIImage ///Stores the captured photo as a UIImage object
    let lens: CameraLens ///wide-angle, telephoto, ultra-wide

    ///Defines how two CapturedImage instances are compared, considered equal if their id match
    static func == (lhs: CapturedImage, rhs: CapturedImage) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
