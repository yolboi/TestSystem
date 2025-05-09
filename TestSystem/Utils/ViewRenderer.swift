//
//  ViewRenderer.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 08/05/2025.
//

import SwiftUI
import UIKit

struct ViewRenderer {
    static func render<Content: View>(view: Content, size: CGSize, completion: @escaping (Data?) -> Void) {
        let window = UIWindow(frame: CGRect(origin: .zero, size: size))
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = window.bounds
        hostingController.view.backgroundColor = .white
        window.rootViewController = hostingController
        window.makeKeyAndVisible()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // længere delay!
            hostingController.view.setNeedsLayout()
            hostingController.view.layoutIfNeeded()

            let format = UIGraphicsPDFRendererFormat()
            let renderer = UIGraphicsPDFRenderer(bounds: window.bounds, format: format)

            let data = renderer.pdfData { context in
                context.beginPage()
                hostingController.view.layer.render(in: context.cgContext)
            }

            completion(data)
        }
    }
}
