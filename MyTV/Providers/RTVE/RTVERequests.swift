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
    static let ztnrRes = "http://ztnr.rtve.es/ztnr/res/"
    static let secret = arrayFrom(string: "yeL&daD3")
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
                return
            }

            guard let assetID = doc.xpath("//div[@class='VideoContainer f16x9']").first?["data-assetid"] else {
                return
            }

            videoSecret(episodeCode: Helpers.createEpisodeCode(assetID: assetID), completion: { url in
                completion(url)
            })
        }
    }

    static func videoSecret(episodeCode: String, completion: @escaping (String) -> Void) {
        let resourceCrypto = Helpers.encryptEpisodeCode(episodeCode: episodeCode)
        Alamofire.request(RTVEURL.ztnrRes.appending(resourceCrypto)).responseString { response in

            guard let base64data = response.result.value else {
                return
            }
            let videoXML = Helpers.decryptEpisodeData(base64data: base64data)
            guard let xml = XML(xml: videoXML, encoding: .utf8) else {
                return
            }
            guard let url = xml.xpath("//preset[@order='0']/response/url").first?.content else { return }
            completion(url)
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

        static func encryptEpisodeCode(episodeCode: String) -> String {
            let cryptor = Cryptor(operation: .encrypt, algorithm: .blowfish, mode: .ECB, padding: .PKCS7Padding, key: RTVEURL.secret, iv: Array<UInt8>())
            let cipherText = cryptor.update(string: episodeCode)?.final()
            guard let cipher = cipherText else { return "" }
            let data = dataFrom(byteArray: cipher)
            let base64Encoded = data.base64EncodedString().replacingOccurrences(of: "/", with: "_")
            return base64Encoded.replacingOccurrences(of: "+", with: "-")
        }

        static func decryptEpisodeData(base64data: String) -> String {
            let cryptor = Cryptor(operation: .decrypt, algorithm: .blowfish, mode: .ECB, padding: .PKCS7Padding, key: RTVEURL.secret, iv: Array<UInt8>())
            let data = Data(base64Encoded: base64data)
            guard let encryptedData = data else { return "" }
            let ciphertext = cryptor.update(data: encryptedData)?.final()
            guard let text = ciphertext else { return "" }
            return text.reduce("") { $0 + String(UnicodeScalar($1)) }
        }


    }
}
