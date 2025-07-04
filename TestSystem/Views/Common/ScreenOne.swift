//
//  ScreenOne.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//
// View showing available full tests and single component tests
//

import SwiftUI

struct ScreenOne: View {
    @EnvironmentObject var navModel: NavigationModel /// Provides access to navigation stack
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel /// Provides access to test results overview
    
    @State private var refreshID = UUID() /// Used to force-refresh the grid on test result updates

    let fullTests: [FullTests] = [
        FullTests(title: "Full screen", icon: "iphone", testType: .fullScreen)
    ]

    let menuItems: [TestMenuItem] = [
        TestMenuItem(title: "Touch", icon: "hand.point.up.braille.fill", testType: .screen),
        TestMenuItem(title: "Haptic", icon: "dot.circle.and.hand.point.up.left.fill", testType: .threeD),
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
            /// Full Tests Section
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

            /// Single Tests Section
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
        .id(refreshID)  /// Force refresh grid when refreshID changes
        .navigationBarBackButtonHidden(true) /// Hide default back button
        .onAppear {
            testOverviewVM.loadResults() /// Reload test results on screen appear
        }
        .onReceive(testOverviewVM.$results) { _ in
            refreshID = UUID()  /// Trigger view refresh when test results change
        }
    }
}

#Preview {
    ScreenOne()
        .environmentObject(NavigationModel())
}
