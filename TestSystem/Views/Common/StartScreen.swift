//
//  StartScreen.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 22/04/2025.
//
// Start screen where users choose their role and continue into the app
//

import SwiftUI

struct StartScreen: View {
    @EnvironmentObject var navModel: NavigationModel /// Access to navigation model for moving into the app

    @State private var userType: UserType = .technicianTest /// Tracks selected user type (default = Technician)
    @State private var showTerms = false /// Controls whether the Terms screen is shown
    
    /// Optional closure to run when user continues (useful for intro-flow setups)
    var onContinue: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 20) {
            /// Title
            Text("Welcome to TestSystem")
                .font(.largeTitle)
                .bold()
            
            /// Role Picker
            Picker("I'm a:", selection: $userType) {
                Text("Technician").tag(UserType.technicianTest)
                Text("Customer").tag(UserType.customerSell)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            /// Continue Button
            DefaultButton(title: "Continue") {
                if userType == .customerSell {
                    showTerms = true /// Show terms if user is a customer
                } else {
                    navModel.navigate(to: userType) /// Navigate directly if technician
                    onContinue?() /// Run optional intro completion
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
        .padding()
        /// Terms Screen for Customers
        .fullScreenCover(isPresented: $showTerms) {
            TermsView(isPresented: $showTerms)
                .interactiveDismissDisabled(true)
                .onDisappear {
                    navModel.navigate(to: userType) /// Navigate after accepting terms
                    onContinue?() /// Run optional intro completion
                }
        }
    }
}

#Preview {
    StartScreen()
}
