//
//  Tile.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/22/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

protocol Tile {
    var title: String { get }
    var description: String { get }
    var image: UIImage { get }

    func actionHandler(presenter: UIViewController)
}
