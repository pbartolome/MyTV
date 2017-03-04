//
//  MainViewController.swift
//  MyTV
//
//  Created by Pablo Bartolome on 1/14/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    private let ATRESMEDIA_USER = ""
    private let ATRESMEDIA_PASSWORD = ""

    var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: TileRowCollection.reuseIdentifier, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: TileRowCollection.reuseIdentifier)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sections = []
        loadLiveTV()
        loadAtresmedia()
        loadRTVE()
    }

    func loadLiveTV() {
        LiveRequests.liveChannels { [weak self] section in
            //TODO change return a Section
            let section = Section(title: section.title, tiles: section.tiles)
            self?.sections.insert(section, at: 0)
            self?.tableView.reloadData()
        }
    }

    func loadAtresmedia() {
        AtresmediaRequests.createSession(username: ATRESMEDIA_USER, password: ATRESMEDIA_PASSWORD) { _ in
            AtresmediaRequests.highlights(completion: { [weak self] highlights in
                let tiles: [Tile] = highlights.items.flatMap { $0.episode }
                let highlightSection = Section(title: "Atresmedia Destacados", tiles: tiles)
                self?.sections.append(highlightSection)
                self?.tableView.reloadData()
            })
        }
    }

    func loadRTVE() {
        RTVERequests.highlights { highlights in
            self.sections.append(Section(title: "RTVE Destacados", tiles: highlights.items))
            self.tableView.reloadData()
        }
    }

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
