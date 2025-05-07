//
//  TestResultService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 02/05/2025.
//

import Foundation
import CoreData

class TestResultService {
    private let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "TestSystem")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error)")
            }
        }
    }

    func save(_ results: [TestResult]) {
        let context = container.viewContext

        for result in results {
            let fetchRequest: NSFetchRequest<TestResultEntity> = TestResultEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", result.id as CVarArg)

            let existing = (try? context.fetch(fetchRequest))?.first
            let entity = existing ?? TestResultEntity(context: context)

            entity.id = result.id
            entity.testType = result.testType.rawValue
            entity.passed = result.passed
            entity.timestamp = result.timestamp
            entity.notes = result.notes
            entity.confirmed = result.confirmed
        }

        do {
            try context.save()
        } catch {
            print("Failed to save TestResults: \(error.localizedDescription)")
        }
    }

    func load() -> [TestResult] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<TestResultEntity> = TestResultEntity.fetchRequest()

        do {
            let entities = try context.fetch(fetchRequest)
            return entities.compactMap { TestResult(from: $0) }
        } catch {
            print("Failed to load TestResults: \(error.localizedDescription)")
            return []
        }
    }

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
