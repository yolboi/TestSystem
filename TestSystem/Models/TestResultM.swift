//
//  TestResultM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 02/05/2025.
//

import Foundation
import CoreData

struct TestResult: Identifiable, Codable, Hashable {
    let id: UUID
    let testType: TestType
    let passed: Bool
    let timestamp: Date
    let notes: String?
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

extension TestResult {
    /// Ny failable init: kun opret hvis alle required felter er gyldige
    init?(from entity: TestResultEntity) {
        guard
            let id        = entity.id,
            let rawType   = entity.testType,
            let type      = TestType(rawValue: rawType),
            let timestamp = entity.timestamp
        else {
            return nil
        }
        self.id        = id
        self.testType  = type
        self.passed    = entity.passed
        self.timestamp = timestamp
        self.notes     = entity.notes
        self.confirmed = entity.confirmed
    }
}
