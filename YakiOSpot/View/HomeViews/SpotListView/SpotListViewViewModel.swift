//
//  SpotListViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import Foundation
import SwiftUI

final class SpotListViewViewModel: ObservableObject {
    // TODO: Find a way to add the Binding var into the viewModel
    // TODO: Find a way to add the two functions into the viewModel
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isShowingSearch: Bool = false
    @Published var mySpots: [Spot] = Spot.mockMySpots
    @Published var topSpots: [Spot] = Spot.mockTopSpots
}
