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
        DispatchQueue.main.async {
            self.results = self.storage.load()
        }
    }

    func addResult(_ result: TestResult) {
        // Filtrer det gamle resultat væk og tilføj det nye — skaber et helt nyt array
        var updated = results.filter { $0.testType != result.testType }
        updated.append(result)
        results = updated // 💥 dette tvinger SwiftUI til at se det som ny værdi
        storage.save(results)
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
