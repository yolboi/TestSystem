//
//  TestReseultVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 02/05/2025.
//

import SwiftUI

class TestOverviewViewModel: ObservableObject {
    @Published var results: [TestResult] = []
    private let storage = TestResultService()

    init() {
        results = storage.load()
    }

    func addResult(_ result: TestResult) {
        results.removeAll { $0.testType == result.testType }
        results.append(result)
        storage.save(results)
    }

    func getResult(for type: TestType) -> TestResult? {
        results.first(where: { $0.testType == type })
    }

    // 👇 Her er din sorterede version
    var sortedResults: [TestResult] {
        results.sorted(by: { $0.timestamp > $1.timestamp })
    }
    
    func clearAll() {
        results.removeAll()
        storage.clear()
    }
}
