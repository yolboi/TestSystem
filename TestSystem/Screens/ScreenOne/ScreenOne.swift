//
//  ScreenOne.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//

import SwiftUI

struct ScreenOne: View {
    @EnvironmentObject var navModel: NavigationModel

    let menuItems: [TestMenuItem] = [
        TestMenuItem(title: "Touch", icon: "iphone.gen3", testType: .screen),
        TestMenuItem(title: "Haptic Touch", icon: "dot.circle.and.hand.point.up.left.fill", testType: .threeD),
        TestMenuItem(title: "Face ID", icon: "faceid", testType: .faceID),
        TestMenuItem(title: "Battery", icon: "battery.50", testType: .battery),
        TestMenuItem(title: "True Tone", icon: "circle.tophalf.filled", testType: .trueTone)
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(menuItems, id: \.self) { item in
                    Button {
                        navModel.path.append(item.testType)
                    } label: {
                        PicButton(title: item.title, image: Image(systemName: item.icon))
                    }
                }
            }
            .padding()
        }
    }
}

#Preview{
    ScreenOne()
        .environmentObject(NavigationModel())
}

