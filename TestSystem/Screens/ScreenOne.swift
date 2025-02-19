//
//  ScreenOne.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 18/02/2025.
//

import SwiftUI

struct ScreenOne: View {
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                DefaultButton(title: "TouchScreen"){
                    print("enter toucharea")
                }
            }
        }
        .padding()
    }
}

#Preview{
    ScreenOne()
}
