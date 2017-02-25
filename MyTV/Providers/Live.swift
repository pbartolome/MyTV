//
//  Live.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/24/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

struct Live: Episode {

    let title: String
    let description: String
    let image: UIImage
    let url: String

    func actionHandler(presenter: UIViewController) {
        let player = PlayerViewController()
        player.play(url: url)
        presenter.present(player, animated: true)
    }
    
}
