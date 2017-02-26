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
    }

    func configureCell(title: String, image: UIImage) {
        imageView.image = image
        label.text = title
    }

    func configureCell(title: String, imageURL: String) {
        label.text = title
        asyncDownloadImage(imageURL: imageURL)
    }

    private func asyncDownloadImage(imageURL: String) {
        Alamofire.request(imageURL).responseImage { [weak self] response in
            guard let strongSelf = self else { return }

            if let image = response.result.value {

                UIView.transition(with: strongSelf.imageView,
                                  duration: 0.2,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    strongSelf.imageView.image = image
                                },completion: nil)
            }
        }
    }

}
