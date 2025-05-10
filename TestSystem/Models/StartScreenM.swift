//
//  StartScreenM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 22/04/2025.
//

import SwiftUI

func loadTerms() -> String {
    guard let url = Bundle.main.url(forResource: "Terms", withExtension: "txt"),
          let content = try? String(contentsOf: url, encoding: .utf8) else {
        return "Kunne ikke indlæse vilkårene."
    }
    return content
}
