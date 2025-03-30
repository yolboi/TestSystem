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
                .background(Theme.button.buttonGradient)
                .cornerRadius(8)
        }
    }
}

struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(title)
                .foregroundColor(Theme.button.accentColor)
                .overlay(Theme.button.buttonGradient)
                .mask(Text(title))
        }
    }
}

struct PicButton: View {
    let title: String
    let image: Image

    var body: some View {
            VStack(spacing: 12) {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)

                Divider() // ← linjen mellem billede og tekst

                Text(title)
                    .foregroundColor(Theme.button.accentColor)
                    .overlay(Theme.button.buttonGradient)
                    .mask(Text(title))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Theme.button.accentColor, lineWidth: 0.5)
            )
        .buttonStyle(PlainButtonStyle()) // så den ikke får blå highlight
        .frame(width: 120, height: 120) // ← kompakt størrelse du kan ændre!
    }
}
/*
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
*/

#Preview {
    PicButton(title: "hej", image: Image(systemName: "swift"))
}
