//
//  BikeRowViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 09/02/2022.
//

import Foundation

final class BikeRowViewModel: ObservableObject {
    @Published var bike: Bike?
    @Published var imageData: Data?
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let user = API.User.CURRENT_USER_OBJECT else { return }
        getBike(for: user)
        downloadBikeImage(for: user)
    }
    
    func getBike(for user: User) {
        guard let user = API.User.CURRENT_USER_OBJECT else { return }
        API.Bike.session.getBike(from: user) { bike in
            self.bike = bike
            self.downloadBikeImage(for: user)
        } onError: { error in
            print("======= \(#function) =====", error)
            self.bike = nil
        }
    }
    
    func downloadBikeImage(for user: User) {
        StorageService.shared.getBikeImage(for: user) { data in
            self.imageData = data
        } onError: { error in
            print("======= \(#function) =====", error)
        }
    }
}
