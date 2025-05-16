//
//  TouchTestM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 05/03/2025.
//
//  Manages a touch grid test by tracking which cells have been touched
//  and determining when the entire screen has been fully tested.
//

import SwiftUI

class TouchTestViewModel: ObservableObject {
    let rows = 20
    let columns = 10

    @Published var touched: [[Bool]]

    init() {
        self.touched = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }

    /// Markerer en celle som rørt
    func markTouched(row: Int, col: Int) {
        if !touched[row][col] {
            touched[row][col] = true
        }
    }

    /// Nulstiller hele grid'en
    func resetGrid() {
        touched = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }

    /// Tjekker om ALLE felter er rørt
    func isTestCompleted() -> Bool {
        for row in touched {
            if row.contains(false) {
                return false
            }
        }
        return true
    }

    /// Opretter og gemmer testresultatet i oversigten
    func saveResult(to overviewVM: TestOverviewViewModel) {
        let passed = isTestCompleted()
        let result = TestResult(
            testType: .screen,
            passed: passed,
            timestamp: Date(),
            notes: passed ? nil : "Not all squares were touched",
            confirmed: true
        )
        overviewVM.addResult(result)
    }
}
