//
//  TileCollectionViewCell.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/22/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

class TileCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "TileCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit
    }


    func configureCell(title: String, image: UIImage) {
        imageView.image = image
        label.text = title
    }

    override func prepareForReuse() {
        self.label.text = ""
        self.imageView.image = nil
    }

}
