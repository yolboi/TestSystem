//
//  TrueToneMV.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//

import Combine

/// ViewModel for True Tone-check
class TrueToneCheckViewModel: ObservableObject {
    /// Brugerens bekræftelse efter manuel kontrol via Kontrolcenter
    @Published var confirmed: Bool = false

    /// Handlingen der udløses, når brugeren bekræfter
    func didConfirm() {
        confirmed = true
    }
}
