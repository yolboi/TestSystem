//
//  PixelTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/04/2025.
//

import SwiftUI

struct PixelTestView: View {
    var onComplete: () -> Void = {}
    
    @State private var started = false
    @StateObject private var vm = PixelTestViewModel()

    var body: some View {
        if started {
            PixelTestScreen(viewModel: vm)
            
            DefaultButton(title: "Done") {
                onComplete()
            }
        } else {
            VStack {
                Text("How to use")
                    .font(.largeTitle)
                    .padding(.top)
                
                Text("Swipe with two fingers to iterate through the colors, mark pixel error with one finger.")
                    .padding()
                
                Spacer()
                
                DefaultButton(title: "Start") {
                    started = true
                }
            }
        }
    }
}
