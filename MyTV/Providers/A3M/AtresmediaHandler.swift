//
//  AtresmediaHandler.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/25/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

extension AtresmediaAPI.Episode: Tile {

    func actionHandler(presenter: UIViewController) {
        AtresmediaRequests.videoURL(contentPk: contentPk) { url in
            let player = PlayerViewController()
            player.play(url: url.url)
            presenter.present(player, animated: true, completion: nil)
        }
    }
}

extension AtresmediaAPI.Section: Tile {

    func actionHandler(presenter: UIViewController) {
        //TODO
    }
}
