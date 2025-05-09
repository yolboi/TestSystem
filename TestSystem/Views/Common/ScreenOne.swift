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
    
    @State private var refreshID = UUID()

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
        TestMenuItem(title: "Pixel", icon: "timelapse", testType: .pixel),
        TestMenuItem(title: "Camera", icon: "camera.shutter.button", testType: .camera)
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            Text("Component Tests")
                .font(.title2)
                .bold()
                .padding(.top)

            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(fullTests, id: \.self) { item in
                    Button {
                        navModel.path.append(item.testType)
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            PicButton(title: item.title, image: Image(systemName: item.icon))
                            if let result = testOverviewVM.results.first(where: { $0.testType == item.testType && $0.confirmed }) {
                                Image(systemName: result.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundColor(result.passed ? .green : .red)
                                    .offset(x: 10, y: -10)
                            }
                        }
                    }
                }
            }
            .padding()

            Text("Single Tests")
                .font(.title2)
                .bold()
                .padding(.top)

            Divider()
                .frame(height: 1)
                .background(Color.gray)

            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(menuItems, id: \.self) { item in
                    Button {
                        navModel.path.append(item.testType)
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            PicButton(title: item.title, image: Image(systemName: item.icon))
                            if let result = testOverviewVM.results.first(where: { $0.testType == item.testType && $0.confirmed }) {
                                Image(systemName: result.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundColor(result.passed ? .green : .red)
                                    .offset(x: 10, y: -10)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .id(refreshID)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            testOverviewVM.loadResults()
        }
        .onReceive(testOverviewVM.$results) { _ in
            refreshID = UUID()
        }
    }
}

#Preview{
    ScreenOne()
        .environmentObject(NavigationModel())
}
