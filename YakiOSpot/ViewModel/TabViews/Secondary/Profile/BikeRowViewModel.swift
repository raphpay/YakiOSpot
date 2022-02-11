//
//  BikeRowViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 09/02/2022.
//

import Foundation

final class BikeRowViewModel: ObservableObject {
    @Published var bike: Bike = Bike(id: UUID().uuidString, model: "")
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let user = API.User.CURRENT_USER_OBJECT else { return }
        API.Bike.session.getBike(from: user) { bike in
            self.bike = bike
        } onError: { error in
            print("======= \(#function) =====", error)
        }
    }
}
