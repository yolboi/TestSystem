//
//  BatteryTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 29/04/2025.
//

import SwiftUI

struct BatteryTest: View {
    var body: some View {
        
        Theme.button.buttonGradient
        .mask(
            Text("The test will preform a simple battery calculation Pressbutton to start")
                .font(.caption)
        )
        
        Spacer()
        
        DefaultButton(title: "Start test", action: {})
        
    }
}

#Preview {
    BatteryTest()
}
