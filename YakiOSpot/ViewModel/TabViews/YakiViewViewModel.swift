//
//  YakiViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 03/01/2022.
//

import Foundation

final class YakiViewViewModel: ObservableObject {
    @Published var peoplePresent: [User] = []
    
    func fetchData() {
        API.Spot.session.getPeople { peoplePresent in
            self.peoplePresent = peoplePresent
        } onError: { error in
            print("======= \(#function) error =====", error)
        }
    }
}
