//
//  SearchViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var spots: [Spot] = []
    @Published var searchedName = ""
    
    var searchResults: [Spot] {
        if searchedName.isEmpty {
            return spots
        } else {
            return spots.filter { $0.name.contains(searchedName) }
        }
    }
    
    func fetchSpots() {
        API.Spot.session.getAllSpots { fetchedSpots in
            self.spots = fetchedSpots
        } onError: { error in
            print(error)
        }

    }
}
