//
//  TestResultService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 02/05/2025.
//

import Foundation

class TestResultService {
    private let key = "savedTestResults"

    func save(_ results: [TestResult]) {
        if let data = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> [TestResult] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([TestResult].self, from: data)) ?? []
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }

    func getResult(for testType: TestType) -> TestResult? {
        load().first(where: { $0.testType == testType })
    }
}
