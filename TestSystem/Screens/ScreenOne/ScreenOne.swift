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
        TestMenuItem(title: "Screen", icon: "display", testType: .screen),
        TestMenuItem(title: "Højttaler", icon: "speaker.wave.2.fill", testType: .speaker),
        TestMenuItem(title: "Face ID", icon: "faceid", testType: .faceID),
        TestMenuItem(title: "Batteri", icon: "battery.100", testType: .battery)
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

