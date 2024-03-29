//
//  API.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import Foundation

struct API {
    static let Auth     = AuthEngineService.shared
    static let User     = UserEngineService.shared
    static let Spot     = SpotEngineService.shared
    static let Token    = FCMTokenEngineService.shared
    static let Session  = SessionEngineService.shared
    static let Bike     = BikeEngineService.shared
}
