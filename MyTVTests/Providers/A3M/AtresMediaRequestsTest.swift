//
//  AtresMediaRequestsTest.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/26/17.
//  Copyright © 2017 PB. All rights reserved.
//

import XCTest
@testable import MyTV
import OHHTTPStubs

class AtresMediaRequestsTest: XCTestCase {

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }

    override func setUp() {
        super.setUp()
        OHHTTPStubs.blockAllServiceCalls()
    }

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

    func testCreateSession() {
        let sessionExpectation = expectation(description: "create session")
        stub(condition: { request -> Bool in

            guard let httpBody = (request as NSURLRequest).ohhttpStubs_HTTPBody() else {
                return false
            }
            let body = String(data: httpBody, encoding: String.Encoding.utf8)

            return isHost("servicios.atresplayer.com")(request)
                && isPath("/j_spring_security_check")(request)
                && body == "j_password=my_password&j_username=my_username"

        }) { _ in

            let stubData = "".data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
        }

        AtresmediaRequests.createSession(username: "my_username", password: "my_password") {
            sessionExpectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

    }



    func testHighlights() {
        let sessionExpectation = expectation(description: "atresmedia highlights")
        stub(condition: isHost("servicios.atresplayer.com") && isPath("/api/v3/highlights")) { _ in
            return OHHTTPStubsResponse(fileAtPath: OHPathForFile("highlights", type(of: self))!, statusCode: 200, headers: ["Content-Type": "application/json"])
        }

        AtresmediaRequests.highlights { response in
            let items = response.items
            XCTAssert(items.count == 35)

            let episodes = items.flatMap { $0.episode }
            XCTAssertEqual(episodes.count, 21)
            XCTAssertEqual(episodes.last!.contentPk, "20170107-EPISODE-01223-false")
            XCTAssertEqual(episodes.last!.title, "laSexta Noche: José Bono (07-01-17)")
            XCTAssertTrue(episodes.last!.description.contains("juicios que darán que hablar"))
            XCTAssertEqual(episodes.last!.urlImage, "http://www.atresplayer.com//clipping/2017/01/07/00634/709.jpg")

            let sections = items.flatMap { $0.section }
            XCTAssertEqual(sections.count, 12)
            XCTAssertEqual(sections.first!.title, "Salvados")
            XCTAssertTrue(sections.first!.description.contains("reportajes de actualidad"))
            XCTAssertEqual(sections.first!.urlImage, "http://www.atresplayer.com//clipping/2015/10/14/00531/709.jpg")

            sessionExpectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
        
    }
}
