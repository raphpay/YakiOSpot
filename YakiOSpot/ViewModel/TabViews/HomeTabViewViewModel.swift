//
//  HomeTabViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 20/12/2021.
//

import Foundation

final class HomeTabViewViewModel: ObservableObject {
    let icons = ["bicycle", "hand.raised.fill", "info.circle"]
    let titles = ["Yaki", "", "Infos"]
    
    @Published var showAlert: Bool = false
}
