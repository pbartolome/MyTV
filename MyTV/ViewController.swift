//
//  ViewController.swift
//  MyTV
//
//  Created by Pablo Bartolome on 1/14/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let playerVC = PlayerViewController()
        self.present(playerVC, animated: true, completion: nil)
    }

}

