//
//  ScreenTwo.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 20/02/2025.
//
import SwiftUI

struct ScreenTwo: View {
    let name = UIDevice.current.name             // "Jarl’s iPhone"
    let systemName = UIDevice.current.systemName // "iOS"
    let systemVersion = UIDevice.current.systemVersion // "17.4"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About Device:")
                .font(.title)

            Text("Model: \(DeviceInfoService.readableModelName())")
            Text("Name: \(name)")
            Text("OS: \(systemName) \(systemVersion)")

            // imei feldt
            
            
        }
        .padding()
    }
}

#Preview {
    ScreenTwo()
}
