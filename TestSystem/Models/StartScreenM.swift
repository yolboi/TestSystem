//
//  StartScreenM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 22/04/2025.
//
//  Defines a helper function to load Terms and Conditions text
//  from "Terms.txt. Returns the file contents or a fallback error message if loading fails.
//

import SwiftUI

///load the contents of “Terms.txt” ( in the Resources map)
func loadTerms() -> String {
    /// Find the URL for "Terms.txt" and read the content as utf-8 sting
    guard let url = Bundle.main.url(forResource: "Terms", withExtension: "txt"),
          let content = try? String(contentsOf: url, encoding: .utf8) else {
        return "Could not load the terms"
    }
    return content
}
