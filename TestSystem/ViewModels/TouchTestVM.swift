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
    let rows: Int = 20  /// Number of rows in the touch grid
    let columns: Int = 10 /// Number of columns in the touch grid
    
    @Published var touched: [[Bool]] /// 2D array to track whether each cell has been touched (true/false)
    
    init() {
        /// Initialize the grid with all fields set to false (untouched)
        self.touched = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }

    /// Marks a specific field as touched
    func markTouched(row: Int, col: Int) {
        if !touched[row][col] {
            touched[row][col] = true
        }
    }
    
    /// Resets the entire grid
    func resetGrid() {
        touched = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }
    
    /// Checks if all fields in the grid have been touched
    func isTestCompleted() -> Bool {
        for row in touched {
            if row.contains(false) {
                return false
            }
        }
        return true
    }
}
