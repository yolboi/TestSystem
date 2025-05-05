//
//  Terms.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 22/04/2025.
//
import SwiftUI

struct TermsView: View {
    @Binding var isPresented: Bool
    @State private var accepted = false
    @State private var hasScrolledToBottom = false

    private let termsText = loadTerms()

    var body: some View {
        VStack(spacing: 16) {
            Text("Vilkår og Betingelser")
                .font(.title2)
                .bold()
                .padding(.top)

            ScrollView {
                Text(termsText)
                    .padding()
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onChange(of: proxy.frame(in: .global).maxY) { value in // nødvendig siden at der nok ellers skal laves en ny sctruct
                                    let screenHeight = UIScreen.main.bounds.height
                                    if value < screenHeight {
                                        hasScrolledToBottom = true
                                    }
                                }
                        }
                    )
            }

            Button(action: {
                accepted.toggle()
            }) {
                HStack(alignment: .top) {
                    Image(systemName: accepted ? "checkmark.square.fill" : "square")
                        .foregroundColor(accepted ? .blue : .gray)
                    Text("I declare that all information is 100% true. False information will result in a fee")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)
            }
            .buttonStyle(.plain)

            DefaultButton(title: "Accepter og fortsæt", action: {
                isPresented = false
            }, isEnabled: accepted && hasScrolledToBottom)
            
            .frame(maxWidth: 300) // eller en anden passende bredde
            .padding()
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}
