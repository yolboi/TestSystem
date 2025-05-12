//
//  CameraCaptureView.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//
//  wrapper and ViewController that allow users to capture a photo with a selected camera lens,
//  and return the result back into the app.
//

import SwiftUI
import AVFoundation

struct CameraCaptureView: UIViewControllerRepresentable {
    var desiredLens: CameraLens  /// Desired lens to use (wide, ultra-wide, telephoto)
    var onImageCaptured: (UIImage?) -> Void  /// Callback when an image is captured

    func makeCoordinator() -> Coordinator {
        Coordinator(onImageCaptured: onImageCaptured)
    }

    func makeUIViewController(context: Context) -> CameraViewController {
        let controller = CameraViewController()
        controller.desiredLens = desiredLens
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}

    // Coordinator to bridge communication from UIKit back to SwiftUI
    class Coordinator: NSObject, CameraViewControllerDelegate {
        let onImageCaptured: (UIImage?) -> Void

        init(onImageCaptured: @escaping (UIImage?) -> Void) {
            self.onImageCaptured = onImageCaptured
        }

        func didCapture(image: UIImage?) {
            onImageCaptured(image)
        }
    }
}

// Delegate protocol to handle photo capture
protocol CameraViewControllerDelegate: AnyObject {
    func didCapture(image: UIImage?)
}

// ViewController that handles live camera preview and photo capture
class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    var desiredLens: CameraLens!  /// what camera lens to use
    weak var delegate: CameraViewControllerDelegate?  /// notify when a picture is taken

    private let session = AVCaptureSession() /// Camera capture session
    private let output = AVCapturePhotoOutput() /// Photo output object
    private var previewLayer: AVCaptureVideoPreviewLayer!  /// Layer showing the camera feed

    /// Called after the view controller's view has been loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera() /// Initialize and configure the camera when the view loads
    }

    /// Sets up the camera session, selects the correct lens, and prepares the live preview
    private func setupCamera() {
        /// Discover the correct camera device based on desired lens
        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [
                .builtInUltraWideCamera,
                .builtInWideAngleCamera,
                .builtInTelephotoCamera
            ],
            mediaType: .video,
            position: .back
        ).devices.first(where: { camera in
            /// Select the camera that matches the user's desired lens
            switch desiredLens {
            case .ultraWide: return camera.deviceType == .builtInUltraWideCamera
            case .wide: return camera.deviceType == .builtInWideAngleCamera
            case .telephoto: return camera.deviceType == .builtInTelephotoCamera
            default: return false
            }
        }) else {
            /// If no matching camera is found, notify delegate with nil and exit setup
            delegate?.didCapture(image: nil)
            return
        }

        do {
            session.beginConfiguration() /// Begin modifying the camera session configuration

            // Add input from selected camera
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
            }

            // Add output for photo capture
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            
            /// Commit the session configuration changes
            session.commitConfiguration()

            // Setup preview layer
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.frame = view.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)

            // Start the camera session in the background
            DispatchQueue.global(qos: .userInitiated).async {
                self.session.startRunning()
            }

            /// Setup "Take Picture" button
            let button = UIButton(type: .system)
            button.setTitle("Take Picture", for: .normal)
            button.tintColor = .white
            button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            button.layer.cornerRadius = 8
            button.addTarget(self, action: #selector(takePicture), for: .touchUpInside)

            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
                button.widthAnchor.constraint(equalToConstant: 200),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
        } catch {
            print("Failed to setup camera: \(error)")
            delegate?.didCapture(image: nil)
        }
    }

    @objc private func takePicture() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }

    // Callback when photo capture finishes
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let data = photo.fileDataRepresentation(), let image = UIImage(data: data) {
            delegate?.didCapture(image: image)
        } else {
            delegate?.didCapture(image: nil)
        }
        session.stopRunning()  /// Stop the camera session after taking a picture
    }
}
