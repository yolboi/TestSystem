//
//  Main.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview{
    MainScreen()
}
