//
//  RTVERequestsTests.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/26/17.
//  Copyright © 2017 PB. All rights reserved.
//

import XCTest
@testable import MyTV

class RTVERequestsTests: XCTestCase {

    func testCreateEpisodeCode() {
        let assetID = "3398659_es_videos"
        let episodeCode = RTVERequests.Helpers.createEpisodeCode(assetID: assetID)
        XCTAssertEqual(episodeCode, "3398659_banebdyede_video_es")
    }

    func testCreateResourceCrypto() {
        let episodeCode = RTVERequests.Helpers.createEpisodeCode(assetID: "3926545_es_videos")
        let base64result = "hpM1CSwhxN_lVR7FSV_TCG6mba5nqN8Z7Lpm50K5VNg="
        XCTAssertEqual(RTVERequests.Helpers.createResourceCrypto(episodeCode: episodeCode), base64result)
    }

}
