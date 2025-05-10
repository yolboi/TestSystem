//
//  CameraCaptureView.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//

import SwiftUI
import AVFoundation

struct CameraCaptureView: UIViewControllerRepresentable {
    var desiredLens: CameraLens
    var onImageCaptured: (UIImage?) -> Void

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

// Kamera Controller med AVFoundation
protocol CameraViewControllerDelegate: AnyObject {
    func didCapture(image: UIImage?)
}

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    var desiredLens: CameraLens!
    weak var delegate: CameraViewControllerDelegate?

    private let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    private func setupCamera() {
        guard let device = AVCaptureDevice.DiscoverySession(
            deviceTypes: [
                .builtInUltraWideCamera,
                .builtInWideAngleCamera,
                .builtInTelephotoCamera
            ],
            mediaType: .video,
            position: .back
        ).devices.first(where: { camera in
            switch desiredLens {
            case .ultraWide: return camera.deviceType == .builtInUltraWideCamera
            case .wide: return camera.deviceType == .builtInWideAngleCamera
            case .telephoto: return camera.deviceType == .builtInTelephotoCamera
            default: return false
            }
        }) else {
            delegate?.didCapture(image: nil)
            return
        }

        do {
            session.beginConfiguration()
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
            }
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            session.commitConfiguration()

            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.frame = view.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)

            // Start kameraet i baggrunden
            DispatchQueue.global(qos: .userInitiated).async {
                self.session.startRunning()
            }

            // Tilføj "Take Picture" knap
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

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let data = photo.fileDataRepresentation(), let image = UIImage(data: data) {
            delegate?.didCapture(image: image)
        } else {
            delegate?.didCapture(image: nil)
        }
        session.stopRunning()
    }
}
