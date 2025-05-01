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
    case shake
    case battery
    case trueTone
    case location
    case ear
    case pixel
    case fullScreen
}

enum ScreenTestStep: CaseIterable {
    case touch, pixel, threeD, trueTone, done
}
