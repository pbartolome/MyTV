//
//  TileRowCollection.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/22/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

protocol TileResponderProtocol {
    func tileSelected(tile: Tile)
}

class TileRowCollection: UITableViewCell {

    static let reuseIdentifier = "TileRowCollection"

    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var tiles = [Tile]()
    var delegate: TileResponderProtocol?

    override func awakeFromNib() {
        clipsToBounds = false

        let nib = UINib(nibName: TileCollectionViewCell.reuseIdentifier, bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: TileCollectionViewCell.reuseIdentifier)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.clipsToBounds = false

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIConstant.tileWidth, height: UIConstant.rowHeight)
        layout.scrollDirection = .horizontal
    }

    func configure(tiles: [Tile]) {
        self.tiles = tiles
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tile = tiles[indexPath.row]
        delegate?.tileSelected(tile: tile)
    }

    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
        return true
    }

    override var preferredFocusedView: UIView? {
        return collectionView
    }
}

extension TileRowCollection: UICollectionViewDelegate {

}

extension TileRowCollection: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tiles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tile = tiles[indexPath.row]
        let cell: TileCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TileCollectionViewCell.reuseIdentifier, for: indexPath) as! TileCollectionViewCell
        cell.configureCell(title: tile.title, image: tile.image)
        return cell
    }
}
