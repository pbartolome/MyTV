//
//  RTVEHandler.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/26/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

extension RTVEAPI.Item: Tile {

    var description: String {
        return ""
    }

    func actionHandler(presenter: UIViewController) {
        RTVERequests.videoURL(websiteURL: link) { url in
            let player = PlayerViewController()
            player.play(url: url)
            presenter.present(player, animated: true, completion: nil)
        }
    }
}
