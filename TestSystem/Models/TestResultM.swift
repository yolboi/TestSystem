//
//  TestResultM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 02/05/2025.
//
//  TestResult represent hardware test outcomes.
//  Supports creation from Core Data entities, conforms to Identifiable,
//  Codable, and Hashable for flexible storage and UI handling.

import Foundation
import CoreData

struct TestResult: Identifiable, Codable, Hashable {
    let id: UUID ///identifier for the test result
    let testType: TestType ///type of test performed (testType enum)
    let passed: Bool /// passed or failed
    let timestamp: Date
    let notes: String? ///optional comment on the testresult
    var confirmed: Bool

    init(id: UUID = UUID(),
         testType: TestType,
         passed: Bool,
         timestamp: Date,
         notes: String? = nil,
         confirmed: Bool = false) {
        self.id = id
        self.testType = testType
        self.passed = passed
        self.timestamp = timestamp
        self.notes = notes
        self.confirmed = confirmed
    }
}

/// failable initializer, can return nil if data is missing or invalid
extension TestResult {
    init?(from entity: TestResultEntity) {
        guard
            let id = entity.id,
            let rawType = entity.testType,
            let type = TestType(rawValue: rawType),
            let timestamp = entity.timestamp
        else {
            return nil
        }
        self.id = id
        self.testType = type
        self.passed = entity.passed
        self.timestamp = timestamp
        self.notes = entity.notes
        self.confirmed = entity.confirmed
    }
}
