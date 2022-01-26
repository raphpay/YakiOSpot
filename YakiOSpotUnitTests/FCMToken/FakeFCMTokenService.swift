//
//  FakeFCMTokenService.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 26/01/2022.
//

import Foundation
@testable import YakiOSpot

final class FakeFCMTokenService : FCMTokenEngine {
    static let shared = FakeFCMTokenService()
    private init() {}
}

extension FakeFCMTokenService {
    func getAllTokens(onSuccess: @escaping (([String]) -> Void), onError: @escaping ((String) -> Void)) {
        if (FakeFCMTokenData.mutableTokens.isEmpty) {
            onError(FakeFCMTokenData.noTokenError)
        } else {
            onSuccess(FakeFCMTokenData.mutableTokens)
        }
    }
    
    func updateFirestorePushTokenIfNeeded() {
        // Nothing to test
    }
}
