//
//  CameraService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//
// camera session management, live preview, and photo capture.

import AVFoundation
import UIKit

class CameraService: NSObject, ObservableObject {
    private var session: AVCaptureSession? ///manages flow of data from input devices (camera) to outputs (photo capture).
    private var photoOutput: AVCapturePhotoOutput? ///still image captures
    private var currentDeviceInput: AVCaptureDeviceInput? ///currently active camera
    
    @Published var capturedImage: UIImage? ///Stores the latest captured photo
    @Published var previewLayer: AVCaptureVideoPreviewLayer? /// real-time preview of camera feed
    
    ///session to use a specific camera (front, back). Creates photo output, and preview of camre feed
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
    
    ///setting session and previewLayer to nil for clean up
    func stopSession() {
        session?.stopRunning()
        session = nil
        previewLayer = nil
    }
    
    ///capture a still image
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    /// Saves test result into CoreData via ViewModel. Checks if: images = number of lenses
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

///Converts captured photo data into a UIImage
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
