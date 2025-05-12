//
//  TestMenuItem.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/03/2025.
//
// used in ScreenOne to list picButton 

import SwiftUI


struct TestMenuItem: Hashable {
    let title: String
    let icon: String
    let testType: TestType
}

struct FullTests: Hashable{
    let title: String
    let icon: String
    let testType: TestType
}
