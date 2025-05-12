//
//  FullScreenTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//
// the FullScreen test flow 
//

import SwiftUI

struct FullScreenTestView: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel
    @EnvironmentObject var navModel: NavigationModel
    
    @StateObject var vm = FullScreenTestViewModel()
    
    var body: some View {
        VStack {
            /// Switch based on the current test step
            switch vm.currentStep {
            case .touch:
                TouchTest(fullScreenVM: vm)

            case .pixel:
                PixelTestView(testOverviewVM: testOverviewVM, onComplete: {
                    vm.goToNextStep()
                })
                .environmentObject(testOverviewVM)
                .environmentObject(navModel)

            case .threeD:
                ThreeDtouchTestView(onComplete: vm.goToNextStep)
                    .environmentObject(testOverviewVM)
                    .environmentObject(navModel)

            case .trueTone:
                TrueToneView(onComplete: vm.goToNextStep)
                    .environmentObject(testOverviewVM)
                    .environmentObject(navModel)
                
            case .done:
                /// Test completion screen after all tests are done
                TestCompletionView(
                    title: "Full ScreenTest is done",
                    message: "You've completed the full screen test",
                    buttonText: "Back to Homescreen"
                )
            }
        }
    }
}
