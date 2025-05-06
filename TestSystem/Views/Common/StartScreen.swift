//
//  StartScreen.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 22/04/2025.
//

import SwiftUI

struct StartScreen: View {
    @EnvironmentObject var navModel: NavigationModel
    @State private var userType: UserType = .technicianTest
    @State private var showTerms = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to TestSystem").font(.largeTitle).bold()
            Text("")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Picker("I'm a:", selection: $userType) {
                Text("Technician").tag(UserType.technicianTest)
                Text("Costumer").tag(UserType.customerSell)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            DefaultButton(title: "Continue") {
                if userType == .customerSell {
                    showTerms = true // 👉 vis TermsView
                } else {
                    navModel.navigate(to: userType) // 👉 direkte videre
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .cornerRadius(8)
            .padding(.horizontal)
        }
        .padding()
        .fullScreenCover(isPresented: $showTerms) {
            TermsView(isPresented: $showTerms)
                .interactiveDismissDisabled(true)
                .onDisappear {
                    navModel.navigate(to: userType)
                }
        }
    }
}


#Preview {
    StartScreen()
}
