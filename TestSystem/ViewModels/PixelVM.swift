//
//  PixelMv.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//

import SwiftUI

@MainActor
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
    
    private let testOverviewVM: TestOverviewViewModel
    private let service = PixelTestService()
    
    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
    }
    
    var currentColor: Color {
        TestColor.allCases[currentColorIndex].color
    }
    
    var testPassed: Bool {
        markedErrors.isEmpty
    }
    
    func nextColor() {
        currentColorIndex = (currentColorIndex + 1) % TestColor.allCases.count
    }
    
    func previousColor() {
        currentColorIndex = (currentColorIndex - 1 + TestColor.allCases.count) % TestColor.allCases.count
    }
    
    func addError(at location: CGPoint) {
        markedErrors.append(location)
    }
    
    func reset() {
        currentColorIndex = 0
        markedErrors.removeAll()
    }
    
    func finishTest() {
        service.saveResult(passed: testPassed, to: testOverviewVM)
    }
}
