//
//  PixelMv.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//

import SwiftUI

class PixelTestViewModel: ObservableObject {
    enum TestColor: CaseIterable {
        case red, green, blue
        
        var color: Color {
            switch self {
            case .red: return .red
            case .green: return .green
            case .blue: return .blue
            }
        }
    }
    
    @Published var currentColorIndex: Int = 0
    @Published var markedErrors: [CGPoint] = []
    
    var currentColor: Color {
        TestColor.allCases[currentColorIndex].color
    }
    
    func nextColor() {
        currentColorIndex = (currentColorIndex + 1) % TestColor.allCases.count
    }
    
    func addError(at location: CGPoint) {
        markedErrors.append(location)
    }
    
    func reset() {
        currentColorIndex = 0
        markedErrors.removeAll()
    }
    
    func previousColor() {
        currentColorIndex = (currentColorIndex - 1 + TestColor.allCases.count) % TestColor.allCases.count
    }
}
