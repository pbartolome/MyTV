//
//  Live.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/24/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

struct Live: Tile {

    let title: String
    let description: String
    let urlImage: String
    let url: String

    func actionHandler(presenter: UIViewController) {
        let player = PlayerViewController()
        player.play(url: url)
        presenter.present(player, animated: true)
    }
    
}
