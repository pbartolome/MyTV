//
//  AtresMediaRequestsTest.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/26/17.
//  Copyright © 2017 PB. All rights reserved.
//

import XCTest
@testable import MyTV

class AtresMediaRequestsTest: XCTestCase {

    func testCreateToken() {
        let contentPk = "20161217-EPISODE-00004-false"
        let time = 1484376342
        let hash = AtresmediaRequests.Helpers.createToken(contentPk: contentPk, timestamp: time, delay: 0)
        XCTAssertEqual(hash, "a56629ac2788830f24967fa74dcef888")
    }
}
