//
//  RTVEAPI.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/26/17.
//  Copyright © 2017 PB. All rights reserved.
//

import Foundation

struct RTVEAPI {

    struct Highlights {
        let items: [Item]
    }

    struct Item {
        let urlImage: String
        let title: String
        let link: String
    }

}
