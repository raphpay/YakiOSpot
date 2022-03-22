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
        FakeUserData.mutableUsers   = FakeUserData.referenceUsers
        FakeUserData.mutableUser    = FakeUserData.correctUser
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
    
    func testGivenCurrentUserIsCorrect_WhenSettingUserPresent_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when setting current user present")
        
        service?.session.setUserPresence(onSuccess: { user in
            XCTAssertEqual(FakeUserData.mutableUser.isPresent, true)
            XCTAssertEqual(FakeUserData.mutableUser.presenceDate, FakeUserData.correctDate)
            XCTAssertEqual(user.id, FakeUserData.mutableUser.id)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenCurrentUserIsIncorrect_WhenSettingUserPresent_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when setting incorrect current user present.")
        
        FakeUserData.mutableUser = FakeUserData.incorrectUser
        
        service?.session.setUserPresence(onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeUserData.incorrectUserError)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenCurrentUserIsCorrect_WhenSettingUserAbsent_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when setting current user absent")
        
        service?.session.setUserAbsence(onSuccess: { user in
            XCTAssertEqual(FakeUserData.mutableUser.isPresent, false)
            XCTAssertEqual(FakeUserData.mutableUser.presenceDate, nil)
            XCTAssertEqual(user, FakeUserData.mutableUser)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenCurrentUserIsIncorrect_WhenSettingUserAbsent_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when setting incorrect current user absent")
        
        FakeUserData.mutableUser = FakeUserData.incorrectUser
        
        service?.session.setUserAbsence(onSuccess: { _ in
            //
        }, onError: { error in
            XCTAssertEqual(error, FakeUserData.incorrectUserError)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
}


// MARK: - Fetch
extension UserServiceTestsCase {
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


// MARK: - Update
extension UserServiceTestsCase {
    func testGivenCorrectUser_WhenUpdatingCurrentUser_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when updating current user")
        
        let updatedUser = FakeUserData.correctUser
        
        service?.session.updateCurrentUser(updatedUser, onSuccess: {
            XCTAssertEqual(FakeUserData.mutableUser, updatedUser)
            expectation.fulfill()
        }, onError: { _ in
            //
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenIncorrectUser_WhenUpdatingCurrentUser_ThenOnErrorIsCalled() {
        let expectation = XCTestExpectation(description: "Error when updating incorrect current user")
        
        let updatedUser = FakeUserData.incorrectUser
        
        service?.session.updateCurrentUser(updatedUser, onSuccess: {
            //
        }, onError: { error in
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
}


// MARK: - Remove
extension UserServiceTestsCase {
    func testGivenCorrectUsers_WhenRemovingThem_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when removing correct outdated users")
        
        var outdatedUser = FakeUserData.mutableUser
        outdatedUser.id = "outdatedUser"
        outdatedUser.presenceDate = FakeUserData.correctDate
        FakeUserData.mutableUsers.append(outdatedUser)
        
        service?.session.removeUsersPresence([outdatedUser], onError: { _ in
            //
        })
        
        if let updatedUser = FakeUserData.mutableUsers.first(where: { $0.id == outdatedUser.id }) {
            XCTAssertEqual(updatedUser.isPresent, false)
            XCTAssertEqual(updatedUser.presenceDate, nil)
            expectation.fulfill()
        }
    
        wait(for: [expectation], timeout: 0.01)
    }
}
