//
//  ScreenOne.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//

import SwiftUI

struct ScreenOne: View {
    @EnvironmentObject var navModel: NavigationModel
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel

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

    //måske ryk den her et andet sted hen
    func testStatusIcon(for type: TestType) -> Image? {
        guard let result = testOverviewVM.results.first(where: { $0.testType == type && $0.confirmed }) else {
            return nil
        }

        // Ekstra sikkerhed: check at testen er nyere end en vis dato
        if result.timestamp < Date(timeIntervalSinceNow: -1) { // f.eks. 1 sekund gammel
            return nil
        }

        return Image(systemName: result.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
    }
    
    var body: some View {
        ScrollView {
            
            Text("Component Tests")
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(fullTests, id: \.self) { item in
                    Button {
                        navModel.path.append(item.testType)
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            PicButton(title: item.title, image: Image(systemName: item.icon))

                            if let icon = testStatusIcon(for: item.testType) {
                                icon
                                    .foregroundColor(icon == Image(systemName: "checkmark.circle.fill") ? .green : .red)
                                    .offset(x: 10, y: -10)
                            }
                        }
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
                        ZStack(alignment: .topTrailing) {
                            PicButton(title: item.title, image: Image(systemName: item.icon))

                            if let icon = testStatusIcon(for: item.testType) {
                                icon
                                    .foregroundColor(icon == Image(systemName: "checkmark.circle.fill") ? .green : .red)
                                    .offset(x: 10, y: -10)
                            }
                        }
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

