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

    func testEncryptEpisodeCode() {
        let episodeCode = RTVERequests.Helpers.createEpisodeCode(assetID: "3926545_es_videos")
        let base64result = "hpM1CSwhxN_lVR7FSV_TCG6mba5nqN8Z7Lpm50K5VNg="
        XCTAssertEqual(RTVERequests.Helpers.encryptEpisodeCode(episodeCode: episodeCode), base64result)
    }

    func testDecryptEpisodeData() {
        let base64data = "4MERagJtyrcfcIv9s4tqGap+thBpEjVF1eTtso6wlZ8PVFHa4cuTeG4XvP1PNomSY/UgjuQwFB67r5ugdtuLyBIiW4dRiTzEQ4gWZbyPVwOQevF93FW6k/3BM0d4wAabMFuZT/1m80cacBtXG6iX6qJZboMCvXGGKYR4VLrXGE8+NDHWdT6kC86yhbR2IlfB7QqQEAPwTmm0a0lpFJI2O2xl4Kf0XGrgeQMsCZpTBxln51MUlse9HVy5XHfH4m8dz5wW8kH/ga8SI759CYFgKLjTEjWoSILPJthi6kou/N6UueA5QSt1qxtrVCDB7ZYABDAHMFIMnJcXN0BNYR/l4fy5rpf4vW2H+dN+DYFHc8rbuS1xK7GLbN+93cTQN4wMWnlCnYFqpHbd19jIMZ98OZ4Id9lMgP9BoZpZQy0b4stTNOblwvzRpcAb8vuV4e2HIQLpZ83hl5dYEnas0/zXEYF74jmHoBsYY0gkwfKjbxEhtzvsLGo0XL2pczfTxrXFlOU5r6Juf4KIreT7TM/BdjUmO4rRT026ZyVMD0mhQ5ho40YlPgSkmgsAggerjeTXzNl6WSw8FyLl1mV4m9mLwWpzRJ82+ulDuN67wFQJe+Hk20AdTF761aX5nO0L/DoXUiCNHTPQMx/DEWH8LntskJznb5K6Vis2MPWanVv+H9wHkt0zKs9h6T/R99FFdoTn5AgDDb0n6H628gl621nAmC+WUNOClX1H8Q9TE2W3dApmz0plPl5WtSQKThfEwdjHeI+dd37T3q61UCpHZH76pTnFphqvt+7givAmd6OyjKwsFuKV6h8Duvy5rpf4vW2H+dN+DYFHc8rbuS1xK7GLbKmlCO7qiM8zTQHpa/nak4Hd19jIMZ98Oc0N6pwWZvGp1htmmX4sODALkT3jmHo0EfzLpJhicYtc/tDyFKXZ4sw2CEYkjtAb6vwuzlksOWpAysazwiR7fciknGdP8nMU4qwCp2NMUz8JNql+oSzhu914yKeRAWszG2qqsvJ5KeaULT/nnBYf1pBzRUqc40xcUjF7ddgsSCUT2m+fBWAK1ETl1mV4m9mLwWpzRJ82+ulDuN67wFQJe+HWqLsNRFTC4vlbDy8a4aM1TipEbF2RnZO2HGQKHEce5cOGr+av5J2ZfWYl1x8i/nN3+hCEg0ODlM5sTHES+eqzksgYv0obXABKFy0a+nKTX2r+y1gdSzZg5QUFxZIWEN9v6gvksIjP+phGug2jw3HXvOtiFB3i2JyYo6R4S746PYrRlibKlO7C4MyWuHJoN5sThnQm2Ks6rTxQOoVlcg3RFoeP3v+Zl3lf18kDrxXsyUKYxeuSPoezeVY2IzboVfKQQZWCE04GpkOIJMQ6NMbGnOdvkrpWKza+lM0j2KJrBP44ZT30LAl3NvOL7LevzcyFJECXaLnZausXCnMGgD2R5euaEVL4z1vdNh/Nw5YFWFbGahKHrePTlOU5r6Juf4KIreT7TM/BdjUmO4rRT026ZyVMD0mhQ5ho40YlPgSkmgsAggerjeTXzNl6WSw8FyLl1mV4m9mLwWpzRJ82+ulDuN67wFQJe+F4BSErsg6FFhfjir1YIKED4ONFDCnwTcK9qXM308a1xZTlOa+ibn+CiK3k+0zPwXY1JjuK0U9NurQp7jelQFirav7LWB1LNmCCQaMuBRokN6atSuPateMO5TzSdRgPzrDl1mV4m9mLwWpzRJ82+ulDuN67wFQJe+F4BSErsg6FFhfjir1YIKED4ONFDCnwTcLDEWH8LntskJznb5K6Vis2MPWanVv+H9ynN4y/9CrptbL6mwOCXb3l"
        let expectedXML = "<?xml version='1.0'?><quality><preset order='0' type='HQ'><response code='ok' geolocalizado='false' GMTEnabled='' GMTDisabled=''><url tipo='' provider='AKAMAI-2770'>http://hlsvod.lvlt.rtve.es/resources/TE_NGVA/mp4/2/8/1488181725582.mp4/playlist.m3u8</url><url tipo='' provider='AKAMAI-3392'>http://hlsvod.akcdn.rtve.es/resources/TE_NGVA/mp4/2/8/1488181725582.mp4/playlist.m3u8</url><url tipo='' provider='AKAMAI_STR-10'>http://mvod.lvlt.rtve.es/resources/TE_NGVA/mp4/2/8/1488181725582.mp4</url></response></preset><preset order='1' type='Alta'><response code='ok' geolocalizado='false' GMTEnabled='' GMTDisabled=''><url tipo='' provider='AKAMAI-2770'>http://hlsvod.lvlt.rtve.es/resources/TE_NGVA/mp4/7/3/1488181696837.mp4/playlist.m3u8</url><url tipo='' provider='AKAMAI-3392'>http://hlsvod.akcdn.rtve.es/resources/TE_NGVA/mp4/7/3/1488181696837.mp4/playlist.m3u8</url><url tipo='' provider='AKAMAI_STR-10'>http://mvod.lvlt.rtve.es/resources/TE_NGVA/mp4/7/3/1488181696837.mp4</url></response></preset><preset order='2' type='Media'><response code='ok' geolocalizado='false' GMTEnabled='' GMTDisabled=''><url tipo='' provider='AKAMAI_STR-10'>http://mvod.lvlt.rtve.es/resources/TE_NGVA/mp4/0/4/1488181708340.mp4</url><url tipo='' provider='AKAMAI-2290'>http://flash1.akamaihd.net.rtve.es/resources/TE_NGVA/mp4/0/4/1488181708340.mp4</url></response></preset></quality>"
        XCTAssertEqual(RTVERequests.Helpers.decryptEpisodeData(base64data: base64data), expectedXML)
    }

    func testTokenizedURLNoChange() {
        let url = "http://hlsvod.lvlt.rtve.es/resources/TE_GL13/mp4/5/7/1488935628075.mp4/playlist.m3u8"
        let tokenized = RTVERequests.Helpers.tokenizedURL(url: url)
        XCTAssertEqual(tokenized, url)
    }

    func testTokenizedURLNoChange2() {
        let url = "http://hlsvod.lvlt.rtve.es/resources/TE_NGVA/mp4/2/5/1489012379652.mp4/playlist.m3u8"
        let tokenized = RTVERequests.Helpers.tokenizedURL(url: url)
        XCTAssertEqual(tokenized, url)
    }

    func testTokenizedURL() {
        let url = "http://mvodt.lvlt.rtve.es/resources/TE_GLESP/mp4/2/6/1488937297962.mp4?nvb=20170309043504=20170309103504=033db630c0972c981edae"
        let tokenized = RTVERequests.Helpers.tokenizedURL(url: url)
        XCTAssertEqual(tokenized, "http://mvodt.lvlt.rtve.es/resources/TE_GLESP/mp4/2/6/1488937297962.mp4?nvb=20170309043504&nva=20170309103504&token=033db630c0972c981edae")
    }

    func testTokenizedURL2() {
        let url = "http://mvodt.lvlt.rtve.es/resources/TE_GLESP/mp4/1/4/1473694690941.mp4?nvb=20170309043547=20170309103547=0d1ff41414a8e3b90edcb"
        let tokenized = RTVERequests.Helpers.tokenizedURL(url: url)
        XCTAssertEqual(tokenized, "http://mvodt.lvlt.rtve.es/resources/TE_GLESP/mp4/1/4/1473694690941.mp4?nvb=20170309043547&nva=20170309103547&token=0d1ff41414a8e3b90edcb")
    }

}
