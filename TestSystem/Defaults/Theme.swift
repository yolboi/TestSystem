//
//  Theme.swift
//  TestSystem
//  123
//  Created by Jarl Boyd Roest on 19/02/2025.
//


import SwiftUI

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
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow, .button:
            return .black
        case .indigo, .magenta, .navy, .oxblood, .purple:
            return .white
        }
    }
    
    var mainColor: Color {
        switch self {
        case .bubblegum:
            return Color(red: 1.0, green: 0.71, blue: 0.77) // F.eks. en bubblegum-rosa nuance
        case .buttercup:
            return Color(red: 1.0, green: 0.96, blue: 0.67) // Buttercup gul
        case .indigo:
            return Color(red: 0.29, green: 0.0, blue: 0.51)  // Indigo
        case .lavender:
            return Color(red: 0.90, green: 0.90, blue: 0.98)  // Lavender
        case .magenta:
            return Color(red: 1.0, green: 0.0, blue: 1.0)       // Magenta
        case .navy:
            return Color(red: 0.0, green: 0.0, blue: 0.5)       // Navy blå
        case .orange:
            return Color(red: 1.0, green: 0.65, blue: 0.0)      // Orange
        case .oxblood:
            return Color(red: 0.27, green: 0.0, blue: 0.0)      // Oxblood (mørk rød)
        case .periwinkle:
            return Color(red: 0.8, green: 0.8, blue: 1.0)        // Periwinkle (lyslilla/blå)
        case .poppy:
            return Color(red: 0.89, green: 0.21, blue: 0.21)     // Poppy rød
        case .purple:
            return Color(red: 0.5, green: 0.0, blue: 0.5)        // Klassisk lilla
        case .seafoam:
            return Color(red: 0.62, green: 0.91, blue: 0.75)     // Seafoam grøn/blå
        case .sky:
            return Color(red: 0.53, green: 0.81, blue: 0.92)     // Sky blå
        case .tan:
            return Color(red: 0.82, green: 0.71, blue: 0.55)     // Tan
        case .teal:
            return Color(red: 0.0, green: 0.5, blue: 0.5)        // Teal
        case .yellow:
            return Color(red: 1.0, green: 1.0, blue: 0.0)        // Gul
        case .button:
            return Color.blue
        }
    }
                
    // Ny property, som returnerer en gradient for knapper
    var buttonGradient: LinearGradient {
        switch self {
        case .button:
            return LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        default:
            // For andre temaer kan du lave en gradient baseret på mainColor eller en enkelt farve
            return LinearGradient(
                gradient: Gradient(colors: [self.mainColor]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}
