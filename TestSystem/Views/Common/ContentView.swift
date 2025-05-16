//
//  ContentView.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel /// Provides access to the shared test overview state
    @EnvironmentObject var navModel: NavigationModel /// Provides access to the shared navigation model
    
    @StateObject var fullScreenVM = FullScreenTestViewModel() /// Manages full screen test logic locally
    @State private var showTabBar = false /// Controls whether to show the TabView or the start screen

    var body: some View {
        Group {
            if showTabBar {
                TabView {
                    /// Home Tab
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
                                    TrueToneView(testOverviewVM: testOverviewVM, onComplete: {})
                                case .battery:
                                    BatteryTestView(testOverviewVM: testOverviewVM)
                                case .location:
                                    LocationTest(locationService: LocationService(), testOverviewVM: testOverviewVM)
                                case .ear:
                                    EarpieceView()
                                case .pixel:
                                    PixelTestView(testOverviewVM: testOverviewVM, onComplete: {})
                                case .fullScreen:
                                    FullScreenTestView()
                                case .camera:
                                    CameraTestView(testOverviewVM: testOverviewVM)
                                }
                            }
                    }
                    .tabItem { Label("Home", systemImage: "house.fill") }

                    /// Test Log Tab
                    NavigationStack {
                        ScreenTwo()
                    }
                    .tabItem { Label("Test Log", systemImage: "pencil") }

                    /// Summary Tab
                    NavigationStack {
                        TestSummaryView()
                    }
                    .tabItem { Label("Summary", systemImage: "list.bullet") }
                }
                .toolbarBackground(Color.blue, for: .tabBar) /// Set tab bar background color
                .toolbarBackground(.visible, for: .tabBar)
                .accentColor(.blue) /// Set tab selection color
            } else {
                /// Initial view — for example, intro, login, or full screen test
                StartScreen(onContinue: {
                    showTabBar = true  /// Triggered when user is ready to enter the main app
                })
            }
        }
    }
}
