//
//  LiveAPI.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/24/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit
import Unbox

struct LiveAPI {

    struct Live: Tile, Unboxable {

        let title: String
        let description: String
        let urlImage: String
        let url: String

        func actionHandler(presenter: UIViewController) {
            let player = PlayerViewController()
            player.play(url: url)
            presenter.present(player, animated: true)
        }

        init(unboxer: Unboxer) throws {
            self.title = try unboxer.unbox(key: "title")
            self.description = try unboxer.unbox(key: "description")
            self.urlImage = try unboxer.unbox(key: "urlImage")
            self.url = try unboxer.unbox(key: "url")
        }

    }

    struct LiveSection: Unboxable {
        let tiles: [Live]
        let title: String

        init(unboxer: Unboxer) throws {
            self.tiles = try unboxer.unbox(key: "tiles")
            self.title = try unboxer.unbox(key: "title")
        }
    }
    
}


