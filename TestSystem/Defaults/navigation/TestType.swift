//
//  TestType.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/03/2025.
//

import Foundation

enum UserType: Hashable {
    case technicianTest
    case customerSell
}

enum TestType: Hashable {
    case screen
    case threeD
    case faceID
    case battery
    case trueTone
}
