//
//  FakeUserService.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 09/12/2021.
//

import Foundation
@testable import YakiOSpot

final class FakeUserService : UserEngine {
    static let shared = FakeUserService()
    private init() {}
}


// MARK: - Post
extension FakeUserService {
    func addUserToDatabase(_ user: User, onSuccess: @escaping (() -> Void), onError: @escaping ((String) -> Void)) {
        //
    }
    
}


// MARK: - Fetch
extension FakeUserService {
    func getUserPseudo(with id: String, onSuccess: @escaping ((String) -> Void), onError: @escaping ((String) -> Void)) {
        //
    }
    
    func getUsersFavoritedSpots(onSuccess: @escaping (([Spot]) -> Void), onError: @escaping ((String) -> Void)) {
        //
    }
}
