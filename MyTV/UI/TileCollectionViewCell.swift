//
//  TileCollectionViewCell.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/22/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TileCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "TileCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    //Keep a reference to prevent adding the wrong image while reusing
    private var imageURL: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
    }

    override func prepareForReuse() {
        self.label.text = ""
        self.imageView.image = nil
        self.imageURL = nil
    }

    func configureCell(title: String, image: UIImage) {
        imageView.image = image
        label.text = title
    }

    func configureCell(title: String, imageURL: String) {
        label.text = title
        asyncDownloadImage(imageURL: imageURL)
        self.imageURL = imageURL
    }

    private func asyncDownloadImage(imageURL: String) {
        Alamofire.request(imageURL).responseImage { [weak self] response in
            guard let strongSelf = self else { return }

            if let image = response.result.value,
                imageURL == self?.imageURL {
                strongSelf.imageView.image = image
            }
        }
    }

}
