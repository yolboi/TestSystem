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

    var onContinue: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to TestSystem").font(.largeTitle).bold()
            
            Picker("I'm a:", selection: $userType) {
                Text("Technician").tag(UserType.technicianTest)
                Text("Costumer").tag(UserType.customerSell)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            DefaultButton(title: "Continue") {
                if userType == .customerSell {
                    showTerms = true
                } else {
                    navModel.navigate(to: userType)
                    onContinue?() // ← hvis du bruger intro-flowet
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
        .padding()
        .fullScreenCover(isPresented: $showTerms) {
            TermsView(isPresented: $showTerms)
                .interactiveDismissDisabled(true)
                .onDisappear {
                    navModel.navigate(to: userType)
                    onContinue?() // ← også her!
                }
        }
    }
}


#Preview {
    StartScreen()
}
