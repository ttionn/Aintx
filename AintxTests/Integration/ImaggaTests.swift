//
//  ImaggaTests.swift
//  AintxTests
//
//  Created by Tong Tian on 10/25/17.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import XCTest
import Aintx

class ImaggaTests: XCTestCase {
    
    var aintx: Aintx!
    var async: XCTestExpectation!
    
    let API_Key = "acc_f204118321e5ff9"
    let API_Secret = "374a892e7f89aaadcd7c98cc63f208b2"
    let Basic_Token = "Basic YWNjX2YyMDQxMTgzMjFlNWZmOTozNzRhODkyZTdmODlhYWFkY2Q3Yzk4Y2M2M2YyMDhiMg=="
    
    override func setUp() {
        super.setUp()

        aintx = Aintx(base: "https://api.imagga.com")
        async = expectation(description: "async")
    }
    
    func testGet() {
        let path = "/v1/tagging"
        let queryDic = ["url": "https://www.sciencenewsforstudents.org/sites/default/files/2016/12/main/articles/860_main_windpower.png"]
        
        var request = aintx.createHttpRequest(path: path, queryDic: queryDic)

        _ = request.setAuthorization(basicToken: Basic_Token)
        
        aintx.go(request) { (response) in
            XCTAssertNotNil(response.data)
            XCTAssertNil(response.error)
            
            self.async.fulfill()
        }
        
        wait(for: [async], timeout: 30)
    }
    
}
