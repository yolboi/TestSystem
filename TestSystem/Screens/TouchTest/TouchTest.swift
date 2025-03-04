//
//  TouchTest.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 04/03/2025.
//

import SwiftUI

struct TouchTest: View {
    let rows: Int = 5
    let columns: Int = 5
    @State var touched: [[Bool]]
    
    init() {
        // Initialiser en 2D-array med false for alle felter.
        _touched = State(initialValue: Array(repeating: Array(repeating: false, count: columns), count: rows))
    }
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(0..<rows, id: \.self) { i in
                HStack(spacing: 2) {
                    ForEach(0..<columns, id: \.self) { j in
                        Rectangle()
                            .fill(touched[i][j] ? Color.green : Color.gray)
                            .frame(width: 60, height: 60)
                            .onTapGesture {
                                touched[i][j] = true
                            }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    TouchTest()
}
