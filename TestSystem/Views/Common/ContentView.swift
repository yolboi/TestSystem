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
            // Home Tab med StartScreen & navigation
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
                        case .screen: TouchTest()
                        case .threeD: ThreeDtouchTestView()
                        case .shake: ShakeTestView()
                        case .trueTone: TrueToneCheckView{navModel.navigate(to: .technicianTest)}
                        case .battery: BatteryTest()
                        case .location: MapScreen()
                        case .ear: EarpieceView()
                        case .pixel: PixelTestView()
                        case .fullScreen: FullScreenTestView()
                        }
                    }
            }
            .tabItem { Label("Home", systemImage: "house.fill") }

            // Settings Tab
            NavigationStack {
                SettingsView()
            }
            .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .toolbarBackground(Color.blue, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .accentColor(.blue)
    }
}

//dummies
//struct FaceIDTestView: View { var body: some View { Text("Face ID Test") }}
struct SettingsView: View { var body: some View {Text("Settings")}}
