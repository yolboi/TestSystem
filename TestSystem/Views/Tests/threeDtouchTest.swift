//
//  3DtouchTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 27/03/2025.
//

import SwiftUI

struct ThreeDtouchTestView: View {
    var onComplete: () -> Void = {}
    @State private var testResult: String? = nil
    var body: some View {
        VStack {
            Text("Touch firmly on the button below")
            .font(.title)
        
            DefaultButton(title:"Haptic Feedback test", action: {testResult = "Failed"})
                .contextMenu{
                    Button("Tab to pass the test"){
                        testResult = "Passed"
                        onComplete()
                    }
                }
            if testResult == "Passed" {
                CheckMarkAnimation(showCheckMark: true)
            }
            else if testResult == "Failed"{
                FailedTest(showFailed: true)
            }
        }
    }
}

#Preview {
    ThreeDtouchTestView()
}
