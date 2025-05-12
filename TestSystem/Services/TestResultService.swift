//
//  TestResultService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 02/05/2025.
//
// Provides a service for saving, loading, and clearing TestResult objects using Core Data.
// Manages persistence through NSPersistentContainer.
//

import Foundation
import CoreData

class TestResultService {
    private let container: NSPersistentContainer

    ///Initializes the Core Data NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "TestSystem")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error)") ///if the loading fails, it tigger an error
            }
        }
    }

    ///saves one or more TestResult objects into Core Data.
    func save(_ results: [TestResult]) {
        let context = container.viewContext ///gets the Core Data context

        for result in results {
            let fetchRequest: NSFetchRequest<TestResultEntity> = TestResultEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", result.id as CVarArg) ///checks if a TestResultEntity already exists with the same id

            let existing = (try? context.fetch(fetchRequest))?.first ///If found, updates the existing entity
            let entity = existing ?? TestResultEntity(context: context) ///If not found, creates a new TestResultEntity.

            entity.id = result.id
            entity.testType = result.testType.rawValue
            entity.passed = result.passed
            entity.timestamp = result.timestamp
            entity.notes = result.notes
            entity.confirmed = result.confirmed
        }

        do {
            try context.save() ///save the context
        } catch {
            print("Failed to save TestResults: \(error.localizedDescription)") /// an error message if failed to save context
        }
    }

    ///Loads all TestResultEntity objects from Core Data and converts them into TestResult structs
    func load() -> [TestResult] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<TestResultEntity> = TestResultEntity.fetchRequest()

        do {
            let entities = try context.fetch(fetchRequest)
            return entities.compactMap { TestResult(from: $0) } ///Uses compactMap to convert each Core Data entity to a Swift TestResult
        } catch {
            print("Failed to load TestResults: \(error.localizedDescription)")
            return []
        }
    }

    /// Deletes all TestResultEntity records from Core Data
    func clear() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TestResultEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to clear TestResults: \(error.localizedDescription)")
        }
    }
}
