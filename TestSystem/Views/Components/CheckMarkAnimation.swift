//
//  CheckMarkAnimation.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 27/03/2025.
//
// Animations for passed and failed tests, not in use yey, only in theeD 
//

import SwiftUI

struct CheckMarkAnimation: View {
    var showCheckMark: Bool
    @State var animate = false

    var body: some View {
        if showCheckMark {
            ZStack {
                Theme.button.buttonGradient
                    .frame(width: 50, height: 50)
                    .mask(
                        Image(systemName: "checkmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    )
            }
            .scaleEffect(showCheckMark ? 1.0 : 0.5)
            .opacity(showCheckMark ? 1 : 0)
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)){
                    animate = true
                }
            }
        }
    }
}

struct SecondaryCheckMarkAnimation: View {
    var showCheckMark: Bool

    var body: some View {
        if showCheckMark {
            ZStack {
                Theme.button.buttonGradient
                    .frame(width: 100, height: 100)
                    .mask(
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    )
            }
            .scaleEffect(showCheckMark ? 1.0 : 0.5)
            .opacity(showCheckMark ? 1 : 0)
            .transition(.scale.combined(with: .opacity))
            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: showCheckMark)
        }
    }
}

struct FailedTest: View {
    var showFailed: Bool
    @State var animate = false

    var body: some View {
        if showFailed {
            ZStack {
                Theme.button.buttonGradient
                    .frame(width: 50, height: 50)
                    .mask(
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    )
            }
            .scaleEffect(showFailed ? 1.0 : 0.5)
            .opacity(showFailed ? 1 : 0)
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)){
                    animate = true
                }
            }
        }
    }
}

#Preview {
    CheckMarkAnimation(showCheckMark: true)
}
