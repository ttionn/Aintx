//
//  SessionManagerTests.swift
//  AintxTests
//
//  Created by Tong Tian on 12/10/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import XCTest
@testable import Aintx

class SessionManagerTests: XCTestCase {
    
    var sut: SessionManager!
    
    override func setUp() {
        super.setUp()
        
        sut = SessionManager.shared
    }

    func testShared() {
        XCTAssertNotNil(sut)
    }
    
    func testGetSessionForStandard() {
        let standard = sut.getSession(with: .standard)
        let standard2 = sut.getSession(with: .standard)
        
        XCTAssertEqual(standard, standard2)
    }
    
    func testGetSessionForEphmeral() {
        let ephemeral = sut.getSession(with: .ephemeral)
        let ephemeral2 = sut.getSession(with: .ephemeral)
        
        XCTAssertEqual(ephemeral, ephemeral2)
    }
    
    func testGetSessionForBackground() {
        let background = sut.getSession(with: .background("background"))
        let background2 = sut.getSession(with: .background("background"))
        let background3 = sut.getSession(with: .background("background3"))
        
        XCTAssertEqual(background, background2)
        XCTAssertNotEqual(background, background3)
    }
    
    func testSubscriptForSessionTasks() {
        let fakeURL = URL(string: "https://httpbin.org")!
        let session = URLSession.shared
        let sessionTask = URLSessionTask()
        let httpTask = HttpDataTask(request: URLRequest(url: fakeURL), session: session, completion: { _ in })
        
        sut[sessionTask] = httpTask
        
        XCTAssertNotNil(sut[sessionTask])
        XCTAssert(sut[sessionTask] is HttpDataTask)
    }
    
    func testSubscriptForRequestGroup() {
        let fakeBase = "http://www.fake.com"
        let fakePath = "/fake/path"
        let fakeURL = URL(string: "https://httpbin.org")!
        let session = URLSession.shared
        let fileTask = HttpFileTask(request: URLRequest(url: fakeURL), session: session, taskType: .file(.download), progress: nil, completed: nil)
//        let fileTask2 = HttpFileTask(request: URLRequest(url: fakeURL), session: session, taskType: .file(.download), progress: nil, completed: nil)
        
        let fileRequest = HttpFileRequest(base: fakeBase, path: fakePath, method: .get, params: nil, headers: nil, sessionConfig: .standard, taskType: .file(.download), completed: nil)
        let fileRequest2 = HttpFileRequest(base: fakeBase, path: fakePath, method: .get, params: nil, headers: nil, sessionConfig: .standard, taskType: .file(.download), completed: nil)
        
        let requestGroup = HttpRequestGroup(lhs: fileRequest, rhs: fileRequest2, type: .concurrent)
        
        sut[fileTask] = requestGroup
        XCTAssertNotNil(sut[fileTask])
    }
    
    func testReset() {
        let session = sut.getSession(with: .standard)
        sut.reset()
        let newSession = sut.getSession(with: .standard)
        
        XCTAssertNotEqual(session, newSession)
    }

}
