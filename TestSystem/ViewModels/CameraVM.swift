//
//  CameraVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//

import Foundation
import SwiftUI
import AVFoundation

class CameraTestViewModel: ObservableObject {
    @Published var capturedImages: [CameraLens: UIImage] = [:]
    @Published var currentLensIndex: Int = 0
    @Published var capturedImage: UIImage?

    let service = CameraService()
    private var testOverviewVM: TestOverviewViewModel
    let lensesToTest: [CameraLens]

    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
        self.lensesToTest = CameraDeviceService.availableLenses()
    }

    var nextLensToCapture: CameraLens? {
        guard currentLensIndex < lensesToTest.count else { return nil }
        return lensesToTest[currentLensIndex]
    }

    var testCompleted: Bool {
        capturedImages.count == lensesToTest.count
    }

    var capturedImagesArray: [CapturedImage] {
        capturedImages.map { CapturedImage(image: $0.value, lens: $0.key) }
    }
    
    func startSession() {
        guard let lens = nextLensToCapture else { return }
        service.configureSession(for: lens.capturePosition)
        service.startSession()
    }

    func stopSession() {
        service.stopSession()
    }

    func capturePhoto() {
        service.capturePhoto()
    }

    func saveCapturedImage() {
        guard let lens = nextLensToCapture, let image = service.capturedImage else { return }
        capturedImages[lens] = image
        currentLensIndex += 1
    }

    func finishTest() {
        let allImages = capturedImages.map { $0.value }
        service.saveResult(capturedImages: allImages, expectedCount: lensesToTest.count, to: testOverviewVM)
    }
}
