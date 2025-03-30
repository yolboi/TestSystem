//
//  ContentView.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navModel: NavigationModel

    var body: some View {
        TabView {
            NavigationStack(path: $navModel.path) {
                ScreenOne()
                    .navigationDestination(for: TestType.self) { test in
                        switch test {
                        case .screen:
                            TouchTest()
                        case .speaker:
                            Text("Lydtest kommer...")
                        case .faceID:
                            Text("Face ID test")
                        case .battery:
                            Text("Batteritest")
                        }
                    }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationStack {
                ScreenTwo()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
        .toolbarBackground(Color.blue, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .accentColor(.blue)
    }
}
