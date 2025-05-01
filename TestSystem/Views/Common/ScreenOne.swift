//
//  ScreenOne.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//

import SwiftUI

struct ScreenOne: View {
    @EnvironmentObject var navModel: NavigationModel

    let fullTests: [FullTests] = [
        FullTests(title: "full screen", icon: "iphone", testType: .fullScreen)
    ]
    
    let menuItems: [TestMenuItem] = [
        TestMenuItem(title: "Touch", icon: "hand.point.up.braille.fill", testType: .screen),
        TestMenuItem(title: "Haptic Touch", icon: "dot.circle.and.hand.point.up.left.fill", testType: .threeD),
        TestMenuItem(title: "Shake", icon: "hands.and.sparkles.fill", testType: .shake),
        TestMenuItem(title: "Battery", icon: "battery.50", testType: .battery),
        TestMenuItem(title: "True Tone", icon: "circle.tophalf.filled", testType: .trueTone),
        TestMenuItem(title: "GPS", icon: "location.fill", testType: .location),
        TestMenuItem(title: "Audio", icon: "ear.badge.waveform", testType: .ear),
        TestMenuItem(title: "Pixel", icon: "timelapse", testType: .pixel)
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            
            Text("Component Tests")
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(fullTests, id: \.self) { item in
                    Button {
                        navModel.path.append(item.testType)
                    } label: {
                        PicButton(title: item.title, image: Image(systemName: item.icon))
                    }
                }
            }
            .padding()
            
            Text("Single tests")
                
            Divider()
                .frame(height: 1) // ændrer tykkelsen
                .background(Color.gray)
            
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

