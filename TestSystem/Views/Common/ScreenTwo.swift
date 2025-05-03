//
//  ScreenTwo.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 20/02/2025.
//
import SwiftUI

struct ScreenTwo: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hej jeg er nr. 2 skærm")
        }
        .padding()
        .onAppear {
            testOverviewVM.clearAll()
        }
    }
}

#Preview {
    ScreenTwo()
}
