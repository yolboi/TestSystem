//
//  Button.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//
// test

import SwiftUI

//den generelle knap
struct DefaultButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}

struct ButtonTest: View {
    var body: some View {
        TabView {
            FirstScreen()
                .tabItem {
                    Label("Første", systemImage: "1.circle")
                }
            
            SecondScreen()
                .tabItem {
                    Label("Anden", systemImage: "2.circle")
                }
        }
    }
}

struct FirstScreen: View {
    var body: some View {
        Text("Dette er den første skærm.")
    }
}

struct SecondScreen: View {
    var body: some View {
        Text("Dette er den anden skærm.")
    }
}


#Preview {
    ButtonTest()
}
