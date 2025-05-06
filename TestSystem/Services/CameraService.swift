//
//  CameraService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 06/05/2025.
//

import UIKit
import AVFoundation

class CameraService: NSObject, ObservableObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @Published var image: UIImage?
    
    func takePhoto(from sourceType: UIImagePickerController.SourceType, completion: @escaping (UIImage?) -> Void) {
        // Du opretter en ImagePickerViewController og håndterer resultatet her
    }
}
