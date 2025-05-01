//
//  FullScreenTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//

import SwiftUI

struct FullScreenTestView: View {
    @StateObject private var vm = FullScreenTestViewModel()
    
    var body: some View {
        VStack {
            switch vm.currentStep {
            case .touch:
                TouchTest(onComplete: vm.goToNextStep)

            case .pixel:
                PixelTestView(onComplete: vm.goToNextStep)

            case .threeD:
                ThreeDtouchTestView(onComplete: vm.goToNextStep)

            case .trueTone:
                TrueToneCheckView(onComplete: vm.goToNextStep)

            case .done:
                VStack {
                    Text("✅ Skærmtest færdig")
                        .font(.largeTitle)
                        .padding()
                    DefaultButton(title: "Tilbage til start") {
                        // evt. navModel.popToRoot() eller noget lign.
                    }
                }
            }
        }
    }
}
