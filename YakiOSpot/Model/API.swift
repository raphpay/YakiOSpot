//
//  API.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import Foundation

struct API {
    static let Auth = AuthEngineService.shared
    static let User = UserService.shared
    static let Spot = SpotService.shared
}
