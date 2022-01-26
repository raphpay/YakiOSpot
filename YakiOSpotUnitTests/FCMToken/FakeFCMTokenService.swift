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
        
    }
    
//    TOKENS_REF.getDocuments { snapshot, error in
//        guard error == nil else {
//            onError(error!.localizedDescription)
//            return
//        }
//        guard let snapshot = snapshot else {
//            onError("No data")
//            return
//        }
//
//        var tokens: [String] = []
//
//        for doc in snapshot.documents {
//            guard let token = doc.data()["fcmToken"] as? String else { return }
//            tokens.append(token)
//        }
//
//        onSuccess(tokens)
//    }
    
    func updateFirestorePushTokenIfNeeded() {
        //
    }
}
