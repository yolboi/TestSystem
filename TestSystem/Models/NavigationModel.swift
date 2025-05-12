//
//  NavigationModel.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/03/2025.
//
// Provides an ObservableObject to manage dynamic navigation paths based on user roles and test types.
// Centralizes navigation control for SwiftUI NavigationStack.
//

import SwiftUI

class NavigationModel: ObservableObject {
    @Published var path = NavigationPath()

    ///UserType navigation, costumer or technician
    func navigate(to user: UserType) {
        path.append(user)
    }

    ///Appends a TestType to the navigation (screen, threeD etc.)
    func navigate(to test: TestType) {
        path.append(test)
    }
    
    ///Pops the last view off the navigation stack, returning to the previous screen... only if if the path is not empty
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
