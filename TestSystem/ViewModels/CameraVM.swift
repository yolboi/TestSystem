//
//  CameraVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//
// Manages camera testing flow including switching lenses,capturing photos,
// updating UI state, and saving results to the TestOverviewViewModel.
//

import Foundation
import SwiftUI
import AVFoundation

class CameraTestViewModel: ObservableObject {
    @Published var capturedImages: [CameraLens: UIImage] = [:] ///A dictionary storing captured images, keyed by the lens they were taken with
    @Published var currentLensIndex: Int = 0 ///lens currently being tested
    @Published var capturedImage: UIImage? ///Stores the latest captured image temporarily (before saving it into capturedImages)

    let service = CameraService()
    private var testOverviewVM: TestOverviewViewModel
    let lensesToTest: [CameraLens]

    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
        self.lensesToTest = CameraDeviceService.availableLenses() ///array of available camera lenses that need to be tested
    }

    ///Returns the next lens that needs to be tested, else returns nil if done
    var nextLensToCapture: CameraLens? {
        guard currentLensIndex < lensesToTest.count else { return nil }
        return lensesToTest[currentLensIndex]
    }

    ///Returns true if all required lenses have been tested
    var testCompleted: Bool {
        capturedImages.count == lensesToTest.count
    }
    /// Converts the captured images dictionary into an array of CapturedImage structs for easy display
    var capturedImagesArray: [CapturedImage] {
        capturedImages.map { CapturedImage(image: $0.value, lens: $0.key) }
    }
    
    ///Starts the camera session for the next lens that needs to be tested
    func startSession() {
        guard let lens = nextLensToCapture else { return }
        service.configureSession(for: lens.capturePosition)
        service.startSession()
    }

    ///stops the current camera session
    func stopSession() {
        service.stopSession()
    }
    
    ///forces the camera to take a photo using the current lens
    func capturePhoto() {
        service.capturePhoto()
    }
    /// Saves the currently captured image to capturedImages dictionary, associated with the current lens. Advances the currentLensIndex to move to the next lens.
    func saveCapturedImage() {
        guard let lens = nextLensToCapture, let image = service.capturedImage else { return }
        capturedImages[lens] = image
        currentLensIndex += 1
    }

    ///Collects all captured images.
    func finishTest() {
        let allImages = capturedImages.map { $0.value }
        service.saveResult(capturedImages: allImages, expectedCount: lensesToTest.count, to: testOverviewVM)
    }
}
