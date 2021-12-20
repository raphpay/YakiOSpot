//
//  HomeTabViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 20/12/2021.
//

import Foundation

final class HomeTabViewViewModel: ObservableObject {
    let icons = ["info.circle", "hand.raised.fill", "bicycle"]
    let titles = ["Info", "", "Feed"]
    
    @Published var selectedIndex: Int = 0
    @Published var showButton: Bool = false
}
