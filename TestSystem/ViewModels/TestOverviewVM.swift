//
//  TestReseultVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 02/05/2025.

//
// Manages the full list of test results for the app, supporting persistent
// saving, updating, and clearing through Core Data.
//

import Foundation
import CoreData
import SwiftUI

class TestOverviewViewModel: ObservableObject {
    
    @Published var results: [TestResult] = [] /// Holds the list of all test results for the current session
    
    private let storage = TestResultService() /// Service for saving, loading, and clearing test results (using Core Data)
    
    init() {
        loadResults() /// Load previously saved results when ViewModel is created
    }

    /// Loads test results from persistent storage
    func loadResults() {
        DispatchQueue.main.async {
            self.results = self.storage.load()
        }
    }

    /// Adds or updates a test result and saves the updated list
    func addResult(_ result: TestResult) {
        var updated = results.filter { $0.testType != result.testType } /// Remove any existing result of the same test type
        updated.append(result) /// Add the new/updated result
        results = updated
        storage.save(results) /// Save to persistent storage
    }

    /// Retrieves the first test result for a given test type, if any
    func getResult(for type: TestType) -> TestResult? {
        results.first(where: { $0.testType == type })
    }

    /// Returns the list of test results sorted by most recent first
    var sortedResults: [TestResult] {
        results.sorted(by: { $0.timestamp > $1.timestamp })
    }

    /// Clears all test results and deletes them from storage
    func clearAll() {
        results.removeAll()
        storage.clear()
    }
}
