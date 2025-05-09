//
//  TouchTestM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 05/03/2025.
//

import SwiftUI

class TouchTestViewModel: ObservableObject {
    let rows: Int = 20
    let columns: Int = 10
    
    @Published var touched: [[Bool]]
    
    init() {
        // Initialize the grid with all fields set to false
        self.touched = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }
    
    // Mark a specific field as touched
    func markTouched(row: Int, col: Int) {
        if !touched[row][col] {
            touched[row][col] = true
        }
    }
    
    // Reset the grid
    func resetGrid() {
        touched = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }
    
    // Check if all fields have been touched (all values in 'touched' are true)
    func isTestCompleted() -> Bool {
        for row in touched {
            if row.contains(false) {
                return false
            }
        }
        return true
    }

    func saveResult(using testOverviewVM: TestOverviewViewModel) {
        let result = TestResult(
            testType: .screen,
            passed: isTestCompleted(),
            timestamp: Date(),
            notes: isTestCompleted() ? nil : "Not all fields were completed",
            confirmed: true
        )
        testOverviewVM.addResult(result)
    }
}
