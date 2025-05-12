//
//  Terms.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 22/04/2025.
//
// View for displaying Terms and Conditions that the user must accept
//

import SwiftUI

struct TermsView: View {
    @Binding var isPresented: Bool /// Controls if this view is shown or dismissed
    @State private var accepted = false  /// Tracks if the user has accepted the declaration
    @State private var hasScrolledToBottom = false /// Tracks if the user has scrolled to the bottom of the terms

    private let termsText = loadTerms() /// Loads the Terms and Conditions text from local file
    
    var body: some View {
        VStack(spacing: 16) {
            /// Title
            Text("Terms and Conditions")
                .font(.title2)
                .bold()
                .padding(.top)

            /// Terms Text
            ScrollView {
                Text(termsText)
                    .padding()
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onChange(of: proxy.frame(in: .global).maxY) {
                                    let screenHeight = UIScreen.main.bounds.height
                                    if proxy.frame(in: .global).maxY < screenHeight {
                                        hasScrolledToBottom = true    // Mark as scrolled when near bottom
                                    }
                                }
                        }
                    )
            }

            /// Accept Checkbox
            Button(action: {
                accepted.toggle()
            }) {
                HStack(alignment: .top) {
                    Image(systemName: accepted ? "checkmark.square.fill" : "square")
                        .foregroundColor(accepted ? .blue : .gray)
                    Text("I declare that all information is true. False information will result in a fee")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)
            }
            .buttonStyle(.plain)

            /// Accept and Continue Button
            DefaultButton(
                title: "Accept and continue",
                action: {
                    isPresented = false  // Dismiss the Terms view
                },
                isEnabled: accepted && hasScrolledToBottom
            )
            .frame(maxWidth: 300)
            .padding()
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true) /// Prevent user from going back without accepting
    }
}
