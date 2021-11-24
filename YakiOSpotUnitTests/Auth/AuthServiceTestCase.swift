//
//  AuthServiceTestCase.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 23/11/2021.
//

import XCTest
@testable import YakiOSpot

class AuthServiceTestCase: XCTestCase {
    
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


// MARK: - Registration
extension AuthServiceTestCase {
    func testGivenEmailAndPasswordAreCorrect_WhenCreatingUser_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when creating user with correct email and password")
        
        service?.session.createUser(email: FakeAuthData.correctEmail2, password: FakeAuthData.correctPassword2,
                                    onSuccess: { userID in
            XCTAssertEqual(FakeAuthData.mutableUsers.count, FakeAuthData.referenceUsers.count + 1)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenUserIsAlreadyRegistered_WhenCreatingUser_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when creating user with correct email and incorrect password")
        
        service?.session.createUser(email: FakeAuthData.correctEmail, password: FakeAuthData.correctPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.alreadySignedInError)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenEmailIsCorrectAndPasswordIsIncorrect_WhenCreatingUser_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when creating user with correct email and incorrect password")
        
        service?.session.createUser(email: FakeAuthData.correctEmail2, password: FakeAuthData.incorrectPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.invalidPasswordError)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenEmailIsCorrectAndPasswordIsEmpty_WhenCreatingUser_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when creating user with correct email and empty password")
        
        service?.session.createUser(email: FakeAuthData.correctEmail2, password: FakeAuthData.emptyPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.emptyPasswordError)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenEmailIsIncorrectAndPasswordIsCorrect_WhenCreatingUser_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when creating user with incorrect email and correct password")
        
        service?.session.createUser(email: FakeAuthData.incorrectEmail, password: FakeAuthData.correctPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.invalidMailError)
            expectation.fulfill()
        })
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenEmailIsEmptyAndPasswordIsCorrect_WhenCreatingUser_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when creating user with empty email and correct password")
        
        service?.session.createUser(email: FakeAuthData.emptyMail, password: FakeAuthData.correctPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.emptyMailError)
            expectation.fulfill()
        })
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenEmailAndPasswordAreIncorrect_WhenCreatingUser_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when creating user with incorrect email and password")
        
        service?.session.createUser(email: FakeAuthData.incorrectEmail, password: FakeAuthData.incorrectPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.invalidMailError)
            expectation.fulfill()
        })
        
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenEmailAndPasswordAreEmpty_WhenCreatingUser_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when creating user with empty email and password")
        
        service?.session.createUser(email: FakeAuthData.emptyMail, password: FakeAuthData.emptyMail, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.emptyMailError)
            expectation.fulfill()
        })
        
        
        wait(for: [expectation], timeout: 0.01)
    }
}


// MARK: - Log in / out
extension AuthServiceTestCase {
    func testGivenEmailAndPasswordAreCorrect_WhenLoggingUserIn_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when logging user in with correct mail and password")
        
        service?.session.signIn(email: FakeAuthData.correctEmail, password: FakeAuthData.correctPassword, onSuccess: { userID in
            XCTAssertEqual(userID, FakeAuthData.mutableUsers[0].id)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenEmailIsIncorrectAndPasswordIsCorrect_WhenLoggingUserIn_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when logging user in with incorrect mail and correct password")
        
        service?.session.signIn(email: FakeAuthData.incorrectEmail, password: FakeAuthData.correctPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.invalidMailError)
            expectation.fulfill()
        })
        
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenEmailIsEmptyAndPasswordIsCorrect_WhenLoggingUserIn_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when logging user in with empty mail and correct password")
        
        service?.session.signIn(email: FakeAuthData.emptyMail, password: FakeAuthData.correctPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.emptyMailError)
            expectation.fulfill()
        })
        
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenEmailIsCorrectAndPasswordIsIncorrect_WhenLoggingUserIn_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when logging user in with correct mail and incorrect password")
        
        service?.session.signIn(email: FakeAuthData.correctEmail, password: FakeAuthData.incorrectPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.invalidPasswordError)
            expectation.fulfill()
        })
        
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenEmailIsCorrectAndPasswordIsEmpty_WhenLoggingUserIn_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when logging user in with correct mail and empty password")
        
        service?.session.signIn(email: FakeAuthData.correctEmail, password: FakeAuthData.emptyPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.emptyPasswordError)
            expectation.fulfill()
        })
        
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenEmailAndPasswordAreIncorrect_WhenLoggingUserIn_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when logging user in with correct mail and incorrect password")
        
        service?.session.signIn(email: FakeAuthData.incorrectEmail, password: FakeAuthData.incorrectPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.invalidMailError)
            expectation.fulfill()
        })
        
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenEmailAndPasswordAreEmpty_WhenLoggingUserIn_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when logging user in with correct mail and incorrect password")
        
        service?.session.signIn(email: FakeAuthData.emptyMail, password: FakeAuthData.emptyPassword, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeAuthData.emptyMailError)
            expectation.fulfill()
        })
        
        
        wait(for: [expectation], timeout: 0.01)
    }
}
