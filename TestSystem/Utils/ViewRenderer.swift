//
//  ViewRenderer.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 08/05/2025.
//
//  Provides a utility for rendering SwiftUI views into PDF data
//

import SwiftUI
import UIKit

struct ViewRenderer {
    
    ///Renders a view into a PDF file
    static func render<Content: View>(view: Content, size: CGSize, completion: @escaping (Data?) -> Void) {
        let window = UIWindow(frame: CGRect(origin: .zero, size: size))
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = window.bounds
        hostingController.view.backgroundColor = .white
        window.rootViewController = hostingController
        window.makeKeyAndVisible()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { ///Waits 300ms to allow the view to fully layout and render!!!
            hostingController.view.setNeedsLayout()
            hostingController.view.layoutIfNeeded()

            let format = UIGraphicsPDFRendererFormat()
            
            ///Draws the view’s visible layer into a PDF context
            let renderer = UIGraphicsPDFRenderer(bounds: window.bounds, format: format)
            let data = renderer.pdfData { context in
                context.beginPage()
                hostingController.view.layer.render(in: context.cgContext)
            }

            completion(data) ///Sends the resulting PDF data back
        }
    }
}
