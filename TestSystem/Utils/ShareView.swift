//
//  ShareView.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 08/05/2025.
//
// Provides a SwiftUI wrapper for presenting the iOS share sheet using UIActivityViewController.
// Used in TestSummary to download as PDF
//

import SwiftUI
import UIKit

struct ShareView: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil) ///no custom activities are added
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
