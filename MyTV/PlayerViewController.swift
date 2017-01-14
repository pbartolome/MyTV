//
//  PlayerViewController.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/22/17.
//  Copyright © 2017 PB. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController, AVPlayerViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.playVideo()
    }

    func playVideo() {
        let parsedURL = URL(string: "http://deswowa3player.antena3.com/vsg/_definst_/smil:assets16/2017/02/18/740A0EBD-F4C5-4B45-880F-EBF7F7FE0843/es.smil/playlist.m3u8?pulse=assets16%2F2017%2F02%2F18%2F740A0EBD-F4C5-4B45-880F-EBF7F7FE0843%2F%7C1487795883%7C6a29ee936e864b0d295f07ca3032fc9f")

        guard let url = parsedURL else {
            print("Invalid URL")
            return
        }

        player = AVPlayer(url: url)
        player?.play()
    }

}
