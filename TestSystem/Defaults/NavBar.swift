//
//  NavBar.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 19/02/2025.
//

/*
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
                CustomNavigationBar() // Vores custom nav-bar med egen "kasse"
                content             // Her kommer resten af indholdet
            }
            .edgesIgnoringSafeArea(.top) // Sørg for, at navbaren kan gå helt op til kanten
        }
    }
}

// Vores custom navigationsbar
struct CustomNavigationBar: View {
    var body: some View {
        HStack {
            NavigationLink(destination: HomeView()) {
                Text("Home")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            Spacer()
            NavigationLink(destination: SettingsView()) {
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        .padding()
        .background(
            // "Kasse" med baggrund, afrundede hjørner og en let skygge
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .shadow(radius: 2)
        )
        .padding([.horizontal, .top])
    }
}

// Eksempel på en skærm
struct HomeView: View {
    var body: some View {
        VStack {
            Text("Dette er Home-skærmen")
                .font(.largeTitle)
            Spacer()
        }
        .padding()
    }
}

// Eksempel på en anden skærm
struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Dette er Settings-skærmen")
                .font(.largeTitle)
            Spacer()
        }
        .padding()
    }
}

// Hovedindholdet med en TabView, der giver navigation mellem skærme
struct ContentView: View {
    var body: some View {
        PersistentNavigationContainer {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                SettingsView()
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
*/
