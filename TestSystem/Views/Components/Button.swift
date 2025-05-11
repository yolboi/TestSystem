//
//  Button.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//
// test

import SwiftUI

//The main button MUST have an action
struct DefaultButton: View {
    let title: String
    let action: () -> Void
    var isEnabled: Bool = true // <-- vigtig defaultværdi

    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background {
                    if isEnabled {
                        Theme.button.buttonGradient
                    } else {
                        Color.gray
                    }
                }
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .disabled(!isEnabled)
    }
}

// the seconday button MUST have an action
struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(title)
                .foregroundColor(Color.black)
                .overlay(Theme.button.buttonGradient)
                .mask(Text(title))
        }
    }
}

// picture button, used in ScreenOne for tests 
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

                Divider()

                Text(title)
                    .foregroundColor(Color.black)
                    .overlay(Theme.button.buttonGradient)
                    .mask(Text(title))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black, lineWidth: 0.5)
            )
        .buttonStyle(PlainButtonStyle()) // så den ikke får blå highlight
        .frame(width: 120, height: 120) // ← kompakt størrelse du kan ændre!
    }
}

#Preview {
    SecondaryButton(title: "hej", action: {})
}
