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

struct RTVEURL {
    static let highlights = "http://www.rtve.es/alacarta/tve/"
    static let baseURL = "http://www.rtve.es/"
}


struct RTVERequests {

    static func highlights(completion: @escaping (RTVEAPI.Highlights) -> Void) {
        Alamofire.request(RTVEURL.highlights).responseString { response in

            guard let html = response.result.value,
                let doc = HTML(html: html, encoding: .utf8) else {
                return //error
            }

            let items = doc.xpath("//span[@class='imgT']").flatMap(parseHighlightsSpan)
            completion(RTVEAPI.Highlights(items: items))

        }
    }

    static private func parseHighlightsSpan(node: XMLElement) -> RTVEAPI.Item? {

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

}
