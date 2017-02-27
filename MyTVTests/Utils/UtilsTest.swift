//
//  UtilsTest.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/26/17.
//  Copyright © 2017 PB. All rights reserved.
//

import Foundation
import XCTest
@testable import MyTV

class UtilsTests: XCTestCase {

    func testDecodingHTMLImageURL() {
        let string: String = "http://img.rtve.es/i/?w=309&amp;crop=no&amp;o=no&amp;i=1488101760364.jpg"
        let decoded = string.decodingHTML()
        XCTAssertEqual(decoded, "http://img.rtve.es/i/?w=309&crop=no&o=no&i=1488101760364.jpg")
    }

    func testDecodingHTMLTitle() {
        let string: String = "Slide La noche tem&aacute;tica - TVE"
        let decoded = string.decodingHTML()
        XCTAssertEqual(decoded, "Slide La noche temática - TVE")
    }

    func testRemovingMatches() {
        let string: String = "http://img.rtve.es/i/?w=309&crop=no&o=no&i=1488101760364.jpg"
        let decoded = try! string.removingMatches(pattern: "\\w=\\d+&")
        XCTAssertEqual(decoded, "http://img.rtve.es/i/?crop=no&o=no&i=1488101760364.jpg")
    }

    func testRemovingMultipleMatches() {
        let string: String = "http://img.rtve.es/i/?w=309&crop=no&o=no&i=1488101760364.jpg"
        let decoded = try! string.removingMatches(pattern: "\\w=\\d+&").removingMatches(pattern: "crop=\\w+&").removingMatches(pattern: "o=\\w+&")
        XCTAssertEqual(decoded, "http://img.rtve.es/i/?i=1488101760364.jpg")
    }

}
