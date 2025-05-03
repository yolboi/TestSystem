//
//  TestEnd.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 03/05/2025.
//

import SwiftUI

struct TestCompletionView: View {
    let title: String
    let message: String
    let buttonText: String

    @EnvironmentObject var navModel: NavigationModel

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.largeTitle)
                .bold()

            Text(message)
                .font(.title3)

            DefaultButton(title: buttonText) {
                navModel.path = NavigationPath()
            }
        }
        .padding()
    }
}
