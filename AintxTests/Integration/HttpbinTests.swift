//
//  HttpbinTests.swift
//  AintxTests
//
//  Created by Tong Tian on 10/24/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import XCTest
import Aintx

class HttpbinTests: XCTestCase {

    var aintx: Aintx!
    var async: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        
        aintx = Aintx(base: "http://httpbin.org")
        async = expectation(description: "async")
    }
    
    func testGet() {
        aintx.go("/get") { (httpResponse) in
            XCTAssertNil(httpResponse.error)
            XCTAssertNotNil(httpResponse.data)
            
            self.async.fulfill()
        }
        
        wait(for: [async], timeout: 5)
    }
    
    func testPostWithParams() {
        aintx.go("/post", method: .post, paramDic: ["foo": "bar"]) { (response) in
            
            XCTAssertNotNil(response.json)
            self.async.fulfill()
        }
        
        wait(for: [async], timeout: 5)
    }
    
    func testGetWithQueryString() {
        // https://httpbin.org/get?show_env=1
        aintx.go("/get", queryDic: ["show_env": "1"]) { (httpResponse) in
            XCTAssertNil(httpResponse.error)
            XCTAssertNotNil(httpResponse.data)
            
            self.async.fulfill()
        }
        
        wait(for: [async], timeout: 5)
    }
    
    func testPost() {
        aintx.go("/post", method: .post) { (httpResponse) in
            XCTAssertNil(httpResponse.error)
            XCTAssertNotNil(httpResponse.data)
            
            self.async.fulfill()
        }
        
        wait(for: [async], timeout: 5)
    }
    
}
