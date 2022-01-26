//
//  FakeFCMTokenData.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 26/01/2022.
//

import Foundation

final class FakeFCMTokenData {
    // MARK: - Tokens
    static let correctToken = "correctToken"
    static let incorrectToken = ""
    
    
    // MARK: - Array
    static let referenceTokens = [correctToken]
    static var mutableTokens = referenceTokens
    
    
    // MARK: - Errors
    static let noTokenError = "noTokenError"
}
