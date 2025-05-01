//
//  CameraTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 26/03/2025.
// test 
 
import SwiftUI
import AVFoundation

struct CameraTestView: View {
    @StateObject private var cameraManager = CameraManager()
    
    var body: some View {
        VStack(spacing: 0) {
            CameraPreview(session: cameraManager.session)
                .onAppear {
                    cameraManager.configure()
                }
                .overlay(
                    Text(cameraManager.currentCameraName)
                        .font(.headline)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(), alignment: .top
                )

            Button("Næste kamera") {
                cameraManager.switchToNextCamera()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)

        DispatchQueue.main.async {
            previewLayer.frame = view.bounds
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

class CameraManager: ObservableObject {
    let session = AVCaptureSession()
    private var deviceInputs: [AVCaptureDeviceInput] = []
    private var cameras: [AVCaptureDevice] = []
    private var currentIndex: Int = 0

    @Published var currentCameraName: String = ""

    func configure() {
        session.beginConfiguration()
        session.sessionPreset = .high

        cameras = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera, .builtInUltraWideCamera, .builtInTelephotoCamera, .builtInTrueDepthCamera],
            mediaType: .video,
            position: .unspecified
        ).devices

        switchToNextCamera()
        session.commitConfiguration()
        session.startRunning()
    }

    func switchToNextCamera() {
        session.beginConfiguration()
        
        // Fjern eksisterende input
        if let currentInput = session.inputs.first {
            session.removeInput(currentInput)
        }

        guard !cameras.isEmpty else { return }

        currentIndex = (currentIndex + 1) % cameras.count
        let newCamera = cameras[currentIndex]

        do {
            let newInput = try AVCaptureDeviceInput(device: newCamera)
            if session.canAddInput(newInput) {
                session.addInput(newInput)
                currentCameraName = cameraName(from: newCamera)
            }
        } catch {
            print("Fejl ved skift af kamera: \(error.localizedDescription)")
        }

        session.commitConfiguration()
    }

    private func cameraName(from device: AVCaptureDevice) -> String {
        switch device.deviceType {
        case .builtInWideAngleCamera: return device.position == .front ? "Frontkamera" : "Bred linse"
        case .builtInUltraWideCamera: return "Ultrawide linse"
        case .builtInTelephotoCamera: return "Tele linse"
        case .builtInTrueDepthCamera: return "TrueDepth (Front)"
        default: return "Ukendt kamera"
        }
    }
}

#Preview {
    VStack {
        Rectangle()
            .foregroundColor(.gray)
            .frame(height: 400)
            .overlay(Text("Camera Preview Placeholder")
                        .foregroundColor(.white)
                        .font(.headline))
        
        Text("Næste kamera-knap her")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
    .padding()
}


