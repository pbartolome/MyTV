//
//  AtresmediaAPI.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/24/17.
//  Copyright © 2017 PB. All rights reserved.
//

import Foundation
import Unbox

struct AtresmediaAPI {

    struct Highlights: Unboxable {
        let items: [Item]

        init(unboxer: Unboxer) throws {
            self.items = try unboxer.unbox(key: "items")
        }
    }

    struct Item: Unboxable {
        let episode: Episode?
        let section: Section?

        init(unboxer: Unboxer) throws {
            self.episode = unboxer.unbox(key: "episode")
            self.section = unboxer.unbox(key: "section")
        }
    }

    struct Episode: Unboxable {
        let title: String
        let description: String
        let contentPk: String
        let urlImage: String

        init(unboxer: Unboxer) throws {
            self.title = try unboxer.unbox(key: "name")
            self.description = try unboxer.unbox(key: "storyline")
            self.contentPk = try unboxer.unbox(key: "contentPk")
            self.urlImage = AtresmediaAPI.toHDurlImage(urlImage: try unboxer.unbox(key: "urlImage"))
        }
    }

    struct Section: Unboxable {
        let title: String
        let description: String
        let urlImage: String

        init(unboxer: Unboxer) throws {
            self.title = try unboxer.unbox(key: "name")
            self.description = try unboxer.unbox(key: "storyline")
            self.urlImage = AtresmediaAPI.toHDurlImage(urlImage: try unboxer.unbox(key: "urlImage"))
        }
    }

    struct ShowEpisodes: Unboxable {
        let episodes: [Item]

        init(unboxer: Unboxer) throws {
            self.episodes = try unboxer.unbox(key: "episodes")
        }
    }

    struct VideoURL: Unboxable {
        let url: String
        
        init(unboxer: Unboxer) throws {
            self.url = try unboxer.unbox(keyPath: "resultObject.es")
        }
    }

    static func toHDurlImage(urlImage: String) -> String {
        return urlImage.replacingOccurrences(of: "/7.jpg", with: "/709.jpg")
    }

}
