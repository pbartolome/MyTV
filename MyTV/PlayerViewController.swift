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

    func play(url: String) {
        let parsedURL = URL(string: url)
        guard let url = parsedURL else {
            print("Invalid URL")
            return
        }
        player = AVPlayer(url: url)
        player?.play()
    }

}
