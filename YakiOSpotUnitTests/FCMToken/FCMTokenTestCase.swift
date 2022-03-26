//
//  FCMTokenTestCase.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 26/01/2022.
//

import XCTest
@testable import YakiOSpot

class FCMTokenTestCase: XCTestCase {

    var session: FCMTokenEngine?
    var service: FCMTokenEngineService?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = FakeFCMTokenService.shared
        service = FCMTokenEngineService(session: session!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        service = nil
        FakeFCMTokenData.mutableTokens = FakeFCMTokenData.referenceTokens
    }
}

extension FCMTokenTestCase {
    func testGivenReferenceTokensAreNotEmpty_WhenGettingAllTokens_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when getting all tokens")

        service?.session.getAllTokens { tokens in
            XCTAssertEqual(tokens, FakeFCMTokenData.referenceTokens)
            expectation.fulfill()
        } onError: { _ in
            //
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenReferenceTokensIsEmpty_WhenGettingAllTokens_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when getting all tokens")

        FakeFCMTokenData.mutableTokens.removeAll()

        service?.session.getAllTokens { _ in
            //
        } onError: { error in
            XCTAssertEqual(error, FakeFCMTokenData.noTokenError)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}
