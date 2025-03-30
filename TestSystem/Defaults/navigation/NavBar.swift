//
//  NavBar.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 19/02/2025.
//
/*
import SwiftUI

struct PersistentNavigationContainer<Content: View>: View {
    @EnvironmentObject var navModel: NavigationModel
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $navModel.path) {
            VStack(spacing: 0) {
                content
            }
            .edgesIgnoringSafeArea(.top)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(for: TestMenuItem.self) { item in
                item.destination
            }
        }
    }
}
*/
