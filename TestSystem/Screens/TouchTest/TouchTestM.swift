//
//  TouchTestM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 05/03/2025.
//

import SwiftUI

class TouchTestM: ObservableObject{
    let rows: Int = 20
    let columns: Int = 10
       
    @Published var touched: [[Bool]]
       
    init() {
        // Initialiserer grid'et med alle felter sat til false
        self.touched = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }
       
       // Marker et specifikt felt som berørt
    func markTouched(row: Int, col: Int) {
        if !touched[row][col]{
            touched[row][col] = true
        }
    }
       
    // Nulstil grid'et
    func resetGrid() {
        touched = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }
       
    // Tjekker om alle felter er blevet berørt (alle værdier i 'touched' er true)
    func isTestCompleted() -> Bool {
        for row in touched {
            if row.contains(false) {
                return false
            }
        }
        return true
    }
}
