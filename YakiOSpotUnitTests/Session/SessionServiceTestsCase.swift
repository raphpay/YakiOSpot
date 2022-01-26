//
//  SessionServiceTestsCase.swift
//  YakiOSpotUnitTests
//
//  Created by Raphaël Payet on 26/01/2022.
//

import XCTest
@testable import YakiOSpot

class SessionServiceTestsCase: XCTestCase {
    var session: SessionEngine?
    var service: SessionEngineService?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = FakeSessionService.shared
        service = SessionEngineService(session: session!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        service = nil
        FakeSessionData.mutableSessions = FakeSessionData.referenceSessions
        FakeSessionData.mutableSession = FakeSessionData.correctSession
    }
}


// MARK: - Post
extension SessionServiceTestsCase {
    func testGivenCreatorIsOK_WhenPostingSession_ThenOnSuccessIsCalled() {
        let expectation = XCTestExpectation(description: "Success when posting a session")
        
        service?.session.postSession(date: Date.now, creator: FakeSessionData.creator, onSuccess: { sessionID in
            XCTAssertEqual(sessionID, FakeSessionData.newCorrectID)
            expectation.fulfill()
        }, onError: { error in
            //
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenUserIsSetPresentAndSessionUsersIsEmpty_WhenSettingUserPresence_ThenSessionUsersCountIsOne() {
        service?.session.setUserPresent(FakeSessionData.correctUser.id, session: FakeSessionData.mutableSession, isPresent: true)
        
        XCTAssertEqual(FakeSessionData.mutableSession.userIDs?.count, 1)
        XCTAssertEqual(FakeSessionData.mutableSession.userIDs?.last, FakeSessionData.correctUser.id)
    }
    
    func testGivenUserIsSetPresentAndSessionUsersIsNotEmpty_WhenSettingUserPresence_ThenSessionUsersCountIsTwo() {
        FakeSessionData.mutableSession = FakeSessionData.newMutableSession
        service?.session.setUserPresent(FakeSessionData.newCorrectUser.id, session: FakeSessionData.mutableSession, isPresent: true)
        
        XCTAssertEqual(FakeSessionData.mutableSession.userIDs?.count, 2)
        XCTAssertEqual(FakeSessionData.mutableSession.userIDs?.last, FakeSessionData.newCorrectUser.id)
    }
    
    func testGivenUserIsSetMissing_WhenSettingUserPresence_ThenSessionUsersCountIsZero() {
        FakeSessionData.mutableSession = FakeSessionData.newMutableSession
        service?.session.setUserPresent(FakeSessionData.correctUser.id, session: FakeSessionData.mutableSession, isPresent: false)
        
        XCTAssertEqual(FakeSessionData.mutableSession.userIDs?.count, 0)
    }
}
