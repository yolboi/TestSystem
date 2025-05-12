//
//  Theme.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 19/02/2025.
//


import SwiftUI

// some usefull colors, taken from apple course 
enum Theme: String {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    case button
    
    var mainColor: Color {
        switch self {
        case .bubblegum:
            return Color(red: 1.0, green: 0.71, blue: 0.77)
        case .buttercup:
            return Color(red: 1.0, green: 0.96, blue: 0.67)
        case .indigo:
            return Color(red: 0.29, green: 0.0, blue: 0.51)
        case .lavender:
            return Color(red: 0.90, green: 0.90, blue: 0.98)
        case .magenta:
            return Color(red: 1.0, green: 0.0, blue: 1.0)
        case .navy:
            return Color(red: 0.0, green: 0.0, blue: 0.5)
        case .orange:
            return Color(red: 1.0, green: 0.65, blue: 0.0)
        case .oxblood:
            return Color(red: 0.27, green: 0.0, blue: 0.0)
        case .periwinkle:
            return Color(red: 0.8, green: 0.8, blue: 1.0)
        case .poppy:
            return Color(red: 0.89, green: 0.21, blue: 0.21)
        case .purple:
            return Color(red: 0.5, green: 0.0, blue: 0.5)
        case .seafoam:
            return Color(red: 0.62, green: 0.91, blue: 0.75)
        case .sky:
            return Color(red: 0.53, green: 0.81, blue: 0.92)
        case .tan:
            return Color(red: 0.82, green: 0.71, blue: 0.55)
        case .teal:
            return Color(red: 0.0, green: 0.5, blue: 0.5)
        case .yellow:
            return Color(red: 1.0, green: 1.0, blue: 0.0)
        case .button:
            return Color.blue
        }
    }
                
    // The gradient color that the modded buttons use
    var buttonGradient: LinearGradient {
        switch self {
        case .button:
            return LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        default:
            return LinearGradient(
                gradient: Gradient(colors: [self.mainColor]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}
