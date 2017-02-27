//
//  RTVERequests.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/26/17.
//  Copyright © 2017 PB. All rights reserved.
//

import Foundation
import Alamofire
import Kanna
import IDZSwiftCommonCrypto

struct RTVEURL {
    static let highlights = "http://www.rtve.es/alacarta/tve/"
    static let baseURL = "http://www.rtve.es/"
}


struct RTVERequests {

    static func highlights(completion: @escaping (RTVEAPI.Highlights) -> Void) {
        Alamofire.request(RTVEURL.highlights).responseString { response in

            guard let html = response.result.value,
                let doc = HTML(html: html, encoding: .utf8) else {
                return
            }

            let items = doc.xpath("//span[@class='imgT']").flatMap(Helpers.parseHighlightsSpan)
            completion(RTVEAPI.Highlights(items: items))

        }
    }

    static func videoURL(websiteURL: String, completion: @escaping (String) -> Void) {
        Alamofire.request(websiteURL).responseString { response in

            guard let html = response.result.value,
                let doc = HTML(html: html, encoding: .utf8) else {
                    return //error
            }

            guard let assetID = doc.xpath("//div[@class='VideoContainer f16x9']").first?["data-assetid"] else {
                return
            }

        }
    }

}

extension RTVERequests {

    struct Helpers {

        static func parseHighlightsSpan(node: XMLElement) -> RTVEAPI.Item? {

            guard let link = node.at_css("a")?["href"],
                let title = node.at_css("a")?["title"],
                let imageURL = node.at_css("img")?["src"] else {
                    return nil
            }

            let parsedLink = RTVEURL.baseURL.appending(link)
            let parsedTitle = title.decodingHTML().removingMatches(pattern: "Slide ")
            let parsedImageURL = imageURL.decodingHTML()

            return RTVEAPI.Item(urlImage:parsedImageURL, title: parsedTitle, link: parsedLink)

        }
        
        static func createEpisodeCode(assetID: String) -> String {
            let params = assetID.components(separatedBy: "_")
            let episeodeCode = params[0]
            let lang = params[1]
            let assetType = params[2].contains("video") ? "video" : "audio"
            return "\(episeodeCode)_banebdyede_\(assetType)_\(lang)"
        }

        static func createResourceCrypto(episodeCode: String) -> String {
            let key = arrayFrom(string: "yeL&daD3")
            let cryptor = Cryptor(operation: .encrypt, algorithm: .blowfish, mode: .ECB, padding: .PKCS7Padding, key: key, iv: Array<UInt8>())
            let cipherText = cryptor.update(string: episodeCode)?.final()
            guard let cipher = cipherText else { return "" }
            let data = dataFrom(byteArray: cipher)
            let base64Encoded = data.base64EncodedString().replacingOccurrences(of: "/", with: "_")
            return base64Encoded.replacingOccurrences(of: "+", with: "-")
        }

        static func createToken() {

        }


    }
}
