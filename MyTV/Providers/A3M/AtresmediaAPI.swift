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
        let section: Dictionary<String, Any>?

        init(unboxer: Unboxer) throws {
            self.episode = unboxer.unbox(key: "episode")
            self.section = unboxer.unbox(key: "section")
        }
    }

    struct Episode: Unboxable {
        let title: String
        let description: String?
        let contentPk: String
        let urlImage: String

        init(unboxer: Unboxer) throws {
            self.title = try unboxer.unbox(key: "name")
            self.description = unboxer.unbox(key: "storyline")
            self.contentPk = try unboxer.unbox(key: "contentPk")
            self.urlImage = try unboxer.unbox(key: "urlImage")
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

}