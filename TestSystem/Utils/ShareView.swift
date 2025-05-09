//
//  ShareView.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 08/05/2025.
//

import SwiftUI
import UIKit

struct ShareView: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
