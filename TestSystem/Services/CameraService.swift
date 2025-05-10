//
//  CameraService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//

import AVFoundation
import UIKit

class CameraService: NSObject, ObservableObject {
    private var session: AVCaptureSession?
    private var photoOutput: AVCapturePhotoOutput?
    private var currentDeviceInput: AVCaptureDeviceInput?
    
    @Published var capturedImage: UIImage?
    @Published var previewLayer: AVCaptureVideoPreviewLayer?
    
    func configureSession(for lensType: AVCaptureDevice.Position) {
        session = AVCaptureSession()
        session?.sessionPreset = .photo
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: lensType) else {
            print("No camera available for \(lensType)")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            
            if let session = session {
                if session.canAddInput(input) {
                    session.addInput(input)
                    currentDeviceInput = input
                }
                
                photoOutput = AVCapturePhotoOutput()
                if let output = photoOutput, session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer = AVCaptureVideoPreviewLayer(session: session)
                previewLayer?.videoGravity = .resizeAspectFill
            }
        } catch {
            print("Error configuring session: \(error)")
        }
    }
    
    func startSession() {
        session?.startRunning()
    }
    
    func stopSession() {
        session?.stopRunning()
        session = nil
        previewLayer = nil
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    /// Gemmer test-resultat i CoreData via ViewModel
    func saveResult(capturedImages: [UIImage], expectedCount: Int, to viewModel: TestOverviewViewModel) {
        let passed = capturedImages.count >= expectedCount
        let result = TestResult(
            testType: .camera,
            passed: passed,
            timestamp: Date(),
            notes: passed ? nil : "Not all camera lenses were tested",
            confirmed: true
        )
        viewModel.addResult(result)
    }
}

extension CameraService: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let data = photo.fileDataRepresentation(),
           let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.capturedImage = image
            }
        }
    }
}
