//
//  NavBar.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 19/02/2025.
//


import SwiftUI

// En container der sikrer, at navigationsbaren er synlig på alle skærme
struct PersistentNavigationContainer<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
               // CustomNavigationBar() // Vores custom nav-bar med egen "kasse"
                content             // Her kommer resten af indholdet
            }
            .edgesIgnoringSafeArea(.top) // Sørg for, at navbaren kan gå helt op til kanten
        }
    }
}

// Hovedindholdet med en TabView, der giver navigation mellem skærme
struct ContentView: View {
    var body: some View {
        PersistentNavigationContainer {
            TabView {
                ScreenOne()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                ScreenTwo()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}

