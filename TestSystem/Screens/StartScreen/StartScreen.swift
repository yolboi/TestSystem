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
    @State private var showTerms: Bool = true

    var body: some View {
        VStack(spacing: 20) {
            Text("Velkommen!").font(.largeTitle).bold()
            Text("Hvad ønsker du at teste med din telefon?")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Picker("Jeg er en…", selection: $userType) {
                Text("Tekniker").tag(UserType.technicianTest)
                Text("Kunde").tag(UserType.customerSell)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            Button("Fortsæt") {
                navModel.navigate(to: userType)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal)
        }
        .padding()
        .fullScreenCover(isPresented: $showTerms) {
            TermsView(isPresented: $showTerms)
        }
    }
}
