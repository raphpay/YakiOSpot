//
//  Bike.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import Foundation

struct Bike: Identifiable, Codable, Hashable {
    let id: String
    let model: String
    let photoURL: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
