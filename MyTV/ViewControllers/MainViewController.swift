//
//  MainViewController.swift
//  MyTV
//
//  Created by Pablo Bartolome on 1/14/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: TileRowCollection.reuseIdentifier, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: TileRowCollection.reuseIdentifier)

        sections.append(LiveSection())

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIConstant.rowHeaderHeight
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = sections[section].title
        label.font = UIFont.boldSystemFont(ofSize: UIConstant.titleFontSize)
        return label
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TileRowCollection.reuseIdentifier) as!  TileRowCollection
        cell.configure(tiles: sections[indexPath.section].tiles)
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstant.rowHeight
    }

    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}

extension MainViewController: TileResponderProtocol {

    func tileSelected(tile: Tile) {
        tile.actionHandler(presenter: self)
    }
    
}
