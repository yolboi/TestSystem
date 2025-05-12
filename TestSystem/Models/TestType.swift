//
//  TestType.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/03/2025.
//
// Defines enums for representing user roles, test types, and step-by-step flows within screen testing.
// Provides structured and codable types for organizing app navigation and behavior.
//

import Foundation

enum UserType: Hashable {
    case technicianTest
    case customerSell
}

enum TestType: String, Codable, Hashable {
    case screen
    case threeD
    case shake
    case battery
    case trueTone
    case location
    case ear
    case pixel
    case fullScreen
    case camera
}

///Represents the individual steps inside Screen Test
enum ScreenTestStep: CaseIterable {
    case touch, pixel, threeD, trueTone, done

    var testType: TestType? {
        switch self {
        case .touch: return .screen
        case .pixel: return .pixel
        case .threeD: return .threeD
        case .trueTone: return .trueTone
        case .done: return nil
        }
    }
}
