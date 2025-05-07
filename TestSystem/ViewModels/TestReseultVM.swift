//
//  TestReseultVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 02/05/2025.
//

import Foundation
import CoreData
import SwiftUI

class TestOverviewViewModel: ObservableObject {
    @Published var results: [TestResult] = []
    private let storage = TestResultService()

    init() {
        loadResults()
    }

    func loadResults() {
        results = storage.load()
    }

    func addResult(_ result: TestResult) {
        // Fjern eksisterende resultat med samme testType, hvis det findes
        if let index = results.firstIndex(where: { $0.testType == result.testType }) {
            results[index] = result
        } else {
            results.append(result)
        }
        storage.save(results)
        loadResults() // Sikrer at UI opdateres med nye værdier
    }

    func getResult(for type: TestType) -> TestResult? {
        results.first(where: { $0.testType == type })
    }

    var sortedResults: [TestResult] {
        results.sorted(by: { $0.timestamp > $1.timestamp })
    }

    func clearAll() {
        results.removeAll()
        storage.clear()
    }
}
