//
//  TestSystemApp.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//

import SwiftUI

@main
struct TestSystemApp: App {
    @StateObject private var navModel = NavigationModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navModel)
        }
    }
}
