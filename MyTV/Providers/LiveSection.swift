//
//  LiveSection.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/24/17.
//  Copyright © 2017 PB. All rights reserved.
//

import Foundation

struct LiveSection: Section {

    let title: String = "Live TV"
    let tiles: [Tile] = Live.liveChannels()
    
}
