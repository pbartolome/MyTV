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
        XCTAssertEqual(hash, "20161217-EPISODE-00004-false|1484376342|a56629ac2788830f24967fa74dcef888")
    }

    func testCreateToken2() {
        let contentPk = "20170227-EPISODE-00911-false"
        let time = 1488242347
        let hash = AtresmediaRequests.Helpers.createToken(contentPk: contentPk, timestamp: time, delay: 0)
        print(hash)
        XCTAssertEqual(hash, "20170227-EPISODE-00911-false|1488242347|29cdcfe03c74146c4f29981a6cd5440c")
    }

}
