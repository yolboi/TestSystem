//
//  ContentView.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel
    @EnvironmentObject var navModel: NavigationModel
    
    @StateObject var fullScreenVM = FullScreenTestViewModel()
    @State private var showTabBar = false // ← Ny state

    var body: some View {
        Group {
            if showTabBar {
                TabView {
                    // Home Tab
                    NavigationStack(path: $navModel.path) {
                        StartScreen()
                            .navigationDestination(for: UserType.self) { user in
                                switch user {
                                case .technicianTest:
                                    ScreenOne()
                                case .customerSell:
                                    ScreenOne()
                                }
                            }
                            .navigationDestination(for: TestType.self) { test in
                                switch test {
                                case .screen:
                                    TouchTest()
                                        .environmentObject(navModel)
                                        .environmentObject(testOverviewVM)
                                        .environmentObject(fullScreenVM)
                                case .threeD:
                                    ThreeDtouchTestView()
                                case .shake:
                                    ShakeTestView()
                                case .trueTone:
                                    TrueToneCheckView { navModel.navigate(to: .technicianTest) }
                                case .battery:
                                    BatteryTestView(testOverviewVM: testOverviewVM)
                                case .location:
                                    MapScreen()
                                case .ear:
                                    EarpieceView()
                                case .pixel:
                                    PixelTestView()
                                case .fullScreen:
                                    FullScreenTestView()
                                case .camera:
                                    CameraTestView(testOverviewVM: testOverviewVM)
                                }
                            }
                    }
                    .tabItem { Label("Home", systemImage: "house.fill") }

                    // Test Log
                    NavigationStack {
                        ScreenTwo()
                    }
                    .tabItem { Label("Test Log", systemImage: "pencil") }

                    // Summary
                    NavigationStack {
                        TestSummaryView()
                    }
                    .tabItem { Label("Summary", systemImage: "list.bullet") }
                }
                .toolbarBackground(Color.blue, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .accentColor(.blue)
            } else {
                // Initial view — fx en intro, login eller full screen test
                StartScreen(onContinue: {
                    showTabBar = true // ← Kaldes fx når brugeren er klar
                })
            }
        }
    }
}
