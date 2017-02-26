//
//  File.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/24/17.
//  Copyright © 2017 PB. All rights reserved.
//

import Foundation

extension Live {

    static func liveChannels() -> [Tile] {

        let tve1 = Live(title: "TVE1", description: "", urlImage: "", url: "http://hlsackdn_gl7-lh.akamaihd.net/i/hlslive_1@439316/master.m3u8")
        let tve2 = Live(title: "La 2", description: "", urlImage: "", url: "http://hlsackdn_gl0-lh.akamaihd.net/i/hlslive_1@439422/master.m3u8")
        let teledeporte = Live(title: "Teledeporte", description: "", urlImage:  "", url: "http://rtve-live.hds.adaptive.level3.net/hls-live/rtvegl1-tdplv3aomgl1/_definst_/live.m3u8")
        let canal24h = Live(title: "Canal 24h", description: "", urlImage: "", url: "http://rtve-live.hds.adaptive.level3.net/hls-live/rtvegl8-24hlv3aomgl8/_definst_/live.m3u8")
        let lasexta = Live(title: "La Sexta", description: "", urlImage: "", url: "http://a3live-lh.akamaihd.net/i/lasexta_1@35272/master.m3u8")
        let antena3 = Live(title: "Antena 3", description: "", urlImage: "", url: "http://a3live-lh.akamaihd.net/i/antena3/antena3_1@35248/master.m3u8")
        let telemadrid = Live(title: "Telemadrid", description: "", urlImage: "", url: "http://telemadrid-live.hls.adaptive.level3.net/hls-live/telemadrid-telemadridbis/_definst_/live.m3u8")

        return [tve1, tve2, teledeporte, canal24h, lasexta, antena3, telemadrid]
    }

}
