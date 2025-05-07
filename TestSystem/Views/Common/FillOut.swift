//
//  FillOut.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 07/05/2025.
//

import SwiftUI

public struct FillOut: View {
    public var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                
                Text("In order to provide an exact price estimation, please fill out the form below.")
                    .padding()
                    .font(.subheadline)
                
                Spacer()
                Divider()
            
                
                SecondaryButton(title: "Complete") {
                    
                }
            }
        }
    }
}

#Preview {
    FillOut()
}
