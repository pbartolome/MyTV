//
//  Section.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/24/17.
//  Copyright © 2017 PB. All rights reserved.
//

import Foundation


/// Sections are displayed on the main screen
/// They contain an array of tiles and a title

protocol Section {

    var title: String { get }
    var tiles: [Tile] { get }

}
