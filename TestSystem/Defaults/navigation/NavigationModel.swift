//
//  NavigationModel.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 30/03/2025.
//

import SwiftUI

class NavigationModel: ObservableObject {
    @Published var path = NavigationPath()

    func navigate(to user: UserType) {
        path.append(user)
    }

    func navigate(to test: TestType) {
        path.append(test)
    }
}
