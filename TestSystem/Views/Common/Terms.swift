//
//  Terms.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 22/04/2025.
//
import SwiftUI

struct TermsView: View {
    @Binding var isPresented: Bool
    @State private var hasScrolledToBottom = false
    @State private var accepted = false
    private let termsText = loadTerms()

    var body: some View {
        VStack(spacing: 16) {
            Text("Vilkår og Betingelser").font(.title2).bold().padding(.top)
            ScrollView {
                Text(termsText).padding()
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onChange(of: proxy.frame(in: .global).maxY) { value in
                                    let screenHeight = UIScreen.main.bounds.height
                                    if value < screenHeight {
                                        hasScrolledToBottom = true
                                    }
                                }
                        }
                    )
            }
            .frame(maxHeight: 300)
            .border(Color.gray)

            Toggle("Jeg erklærer, at alle oplysninger er 100% sande. Falske oplysninger medfører gebyr.", isOn: $accepted)
                .padding(.horizontal)

            Button(action: { isPresented = false }) {
                Text("Accepter og fortsæt")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background((accepted && hasScrolledToBottom) ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(!(accepted && hasScrolledToBottom))
            .padding(.horizontal)
            Spacer()
        }
    }
}
