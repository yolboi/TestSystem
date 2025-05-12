//
//  TestSystemTests.swift
//  TestSystemTests
//
//  Created by Jarl Boyd Roest on 12/05/2025.
//

import XCTest
@testable import TestSystem

final class TestSystemTests: XCTestCase {
    
    func testMarkTouchedUpdatesState() {
        let viewModel = TouchTestViewModel()
        
        viewModel.markTouched(row: 0, col: 0)
        
        XCTAssertTrue(viewModel.touched[0][0], "Field at (0,0) should be marked as touched")
    }
    
    func testIsTestCompletedInitiallyFalse() {
        let viewModel = TouchTestViewModel()
        
        XCTAssertFalse(viewModel.isTestCompleted(), "Test should not be completed initially")
    }
    
    func testIsTestCompletedAfterTouchingAllFields() {
        let viewModel = TouchTestViewModel()
        
        for row in 0..<viewModel.rows {
            for col in 0..<viewModel.columns {
                viewModel.markTouched(row: row, col: col)
            }
        }
        
        XCTAssertTrue(viewModel.isTestCompleted(), "Test should be completed when all fields are touched")
    }
    
    func testResetGridSetsAllFieldsToFalse() {
        let viewModel = TouchTestViewModel()
        
        // Simulate touches
        viewModel.markTouched(row: 0, col: 0)
        viewModel.markTouched(row: 1, col: 1)
        
        viewModel.resetGrid()
        
        for row in viewModel.touched {
            for value in row {
                XCTAssertFalse(value, "All fields should be reset to false")
            }
        }
    }
}
