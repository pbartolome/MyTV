//
//  Show.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/22/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

protocol Show: Tile {

    var seasons: [Season] { get }
    
}
