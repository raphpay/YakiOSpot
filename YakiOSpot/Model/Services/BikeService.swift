//
//  BikeService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import Foundation


protocol BikeEngine {}

final class BikeEngineService {
    var session: BikeEngine
    
    static let shared = BikeEngineService()
    init(session: BikeEngine = BikeService.shared) {
        self.session = session
    }
}

final class BikeService: BikeEngine {
    static let shared = BikeService()
    private init() {}
}
