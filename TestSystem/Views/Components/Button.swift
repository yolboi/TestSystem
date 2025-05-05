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

                Divider()

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

#Preview {
    PicButton(title: "hej", image: Image(systemName: "swift"))
}
