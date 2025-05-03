//
//  TestResultM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 02/05/2025.
//

import Foundation

struct TestResult: Identifiable, Codable, Hashable {
    let id: UUID
    let testType: TestType
    let passed: Bool
    let timestamp: Date
    let notes: String?
    var confirmed: Bool = false // 👈 NY

    init(id: UUID = UUID(), testType: TestType, passed: Bool, timestamp: Date, notes: String? = nil, confirmed: Bool = false) {
        self.id = id
        self.testType = testType
        self.passed = passed
        self.timestamp = timestamp
        self.notes = notes
        self.confirmed = confirmed
    }
}
