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
        
        // Provides a SwiftUI Color corresponding to each test color
        var color: Color {
            switch self {
            case .red: return .red
            case .green: return .green
            case .blue: return .blue
            }
        }
    }
    
    @Published var currentColorIndex: Int = 0 /// Tracks which color is currently being displayed
    @Published var markedErrors: [CGPoint] = [] /// Stores points where pixel errors are marked by the user
    
    private let testOverviewVM: TestOverviewViewModel /// ViewModel to collect and manage test results
    private let service = PixelTestService() /// handle saving pixel test results
    
    init(testOverviewVM: TestOverviewViewModel) {
        self.testOverviewVM = testOverviewVM
    }
    

    /// Returns the currently active test color
    var currentColor: Color {
        TestColor.allCases[currentColorIndex].color
    }
    
    /// Checks whether the pixel test passed (no errors marked)
    var testPassed: Bool {
        markedErrors.isEmpty
    }

    /// Moves to the next color in the test sequence
    func nextColor() {
        currentColorIndex = (currentColorIndex + 1) % TestColor.allCases.count
    }
    
    /// Moves to the previous color in the test sequence
    func previousColor() {
        currentColorIndex = (currentColorIndex - 1 + TestColor.allCases.count) % TestColor.allCases.count
    }
    
    /// Adds a marked error point when the user detects a pixel issue
    func addError(at location: CGPoint) {
        markedErrors.append(location)
    }
    
    /// Resets the test (starting color and clears any marked errors)
    func reset() {
        currentColorIndex = 0
        markedErrors.removeAll()
    }
    
    /// Finishes the pixel test and saves the result
    func finishTest() {
        service.saveResult(passed: testPassed, to: testOverviewVM)
    }
}
