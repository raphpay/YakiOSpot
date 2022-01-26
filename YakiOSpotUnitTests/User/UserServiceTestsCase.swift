//
//  UserServiceTestsCase.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 10/12/2021.
//

import XCTest
@testable import YakiOSpot

class UserServiceTestsCase: XCTestCase {

    var session: UserEngine?
    var service: UserEngineService?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = FakeUserService.shared
        service = UserEngineService(session: session!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        service = nil
        FakeUserData.mutableUsers = FakeUserData.referenceUsers
    }
}


// MARK: - Post
extension UserServiceTestsCase {
    func testGivenUserIsCorrect_WhenAddingToDatabase_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when adding correct user to database")
        
        service?.session.addUserToDatabase(FakeUserData.correctNewUser, onSuccess: {
            XCTAssertEqual(FakeUserData.mutableUsers.count, FakeUserData.referenceUsers.count + 1)
            XCTAssertEqual(FakeUserData.mutableUsers.last?.id, FakeUserData.correctNewUser.id)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenUserIsIncorrect_WhenAddingToDatabase_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when adding incorrect user to database")
        
        service?.session.addUserToDatabase(FakeUserData.incorrectUser, onSuccess: {
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeUserData.postError)
            expectation.fulfill()
        })
        
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenUserIsNotPresent_WhenTogglingPresence_ThenOnSuccessIsCalledAndPresenceIsTrue() {
        let expectation = XCTestExpectation(description: "Success when switching from not present to present.")
        
        service?.session.toggleUserPresence(FakeUserData.correctUser, onSuccess: { isPresent in
            XCTAssertEqual(isPresent, true)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenUserIsPresent_WhenTogglingPresence_ThenOnSuccessIsCalledAndPresenceIsFalse() {
        let expectation = XCTestExpectation(description: "Success when switching from present to not present.")
        
        service?.session.toggleUserPresence(FakeUserData.presentUser, onSuccess: { isPresent in
            XCTAssertEqual(isPresent, false)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenUserHasNoSessionRegistered_WhenAddingSession_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when adding a session to a user with no initial session")
        
        let sessionID = UUID().uuidString
        service?.session.addSessionToUser(sessionID: sessionID, to: FakeUserData.correctUser, onSuccess: { newUser in
            XCTAssertEqual(newUser.sessions?.count, 1)
            XCTAssertEqual(sessionID, newUser.sessions?.last)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenUserHasOneSessionRegistered_WhenAddingSession_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when adding a session to a user with one session")
        
        let sessionID = UUID().uuidString
        service?.session.addSessionToUser(sessionID: sessionID, to: FakeUserData.oneSessionUser, onSuccess: { newUser in
            XCTAssertEqual(newUser.sessions?.count, 2)
            XCTAssertEqual(sessionID, newUser.sessions?.last)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
}


// MARK: - Fetch
extension UserServiceTestsCase {
    func testGivenUserExists_WhenGettingUserPseudo_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when getting correct user pseudo")
        
        service?.session.getUserPseudo(with: FakeUserData.correctID, onSuccess: { pseudo in
            XCTAssertEqual(pseudo, FakeUserData.correctPseudo)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenUserDoesNotExists_WhenGettingUserPseudo_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when getting incorrect user pseudo")
        
        service?.session.getUserPseudo(with: FakeUserData.incorrectID, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeUserData.noUserError)
            expectation.fulfill()
        })
        
        
        wait(for: [expectation], timeout: 0.01)
    }


    func testGivenUIDIsRegistered_WhenGettingUser_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when getting user from correct UID")
        
        service?.session.getUserFromUID(FakeUserData.correctID, onSuccess: { user in
            XCTAssertEqual(user.id, FakeUserData.correctID)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenUIDIsNotRegistered_WhenGettingUser_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when getting user from correct UID")
        
        service?.session.getUserFromUID(FakeUserData.incorrectID, onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeUserData.noUserError)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
}
