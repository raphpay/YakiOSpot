//
//  AuthServiceTestCasePassword.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 26/01/2022.
//

import XCTest
@testable import YakiOSpot

class AuthServiceTestCasePassword: XCTestCase {

    var session: AuthEngine?
    var service: AuthEngineService?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = FakeAuthService.shared
        service = AuthEngineService(session: session!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        service = nil
        FakeAuthData.mutableUsers = FakeAuthData.referenceUsers
    }
}

extension AuthServiceTestCasePassword {
    func testGivenUserMailIsCorrect_WhenSendingResetPasswordMail_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when sending reset password mail")
        
        let user = FakeAuthData.correctUser
        
        service?.session.sendResetPasswordMail(to: user.mail,
                                               onSuccess: {
                                                expectation.fulfill()
                                               }, onError: { _ in
                                                //
                                               })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenUserMailIsIncorrect_WhenSendingResetPasswordMail_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when sending reset password mail to incorrect mail")
        
        var user = FakeAuthData.correctUser
        user.mail = ""
        
        service?.session.sendResetPasswordMail(to: user.mail,
                                               onSuccess: {
                                                //
                                               }, onError: { error in
                                                XCTAssertEqual(error, FakeAuthData.emptyMailError)
                                                expectation.fulfill()
                                               })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenUserMailIsNotRegistered_WhenSendingResetPasswordMail_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when sending reset password mail to not registered mail")
        
        let user = FakeAuthData.notRegisteredUser
        
        service?.session.sendResetPasswordMail(to: user.mail,
                                               onSuccess: {
                                                //
                                               }, onError: { error in
                                                XCTAssertEqual(error, FakeAuthData.alreadySignedInError)
                                                expectation.fulfill()
                                               })
        
        wait(for: [expectation], timeout: 0.01)
    }
}
