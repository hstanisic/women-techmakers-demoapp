//
//  PopularViewController.swift
//  WorkshopDemo
//
//  Created by Hrvoje Stanisic on 20.09.18.
//  Copyright © 2018 WomenInTech. All rights reserved.
//

import Foundation
import UIKit

public class PopularViewController: UITableViewController {

    private let service = TvShowService()
    private var dataSource: TvShowResult?

    override public func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        loadPopular()
    }

    private func loadPopular() {
        service.fetchPopular() { [weak self] dataSource in
            self?.dataSource = dataSource
            self?.tableView.reloadData()
        }
    }

    private func initialize() {
        tableView.rowHeight = 200
        tableView.tableFooterView = UIView()
        registerCells()
    }

    private func tvShow(for indexPath: IndexPath) -> TvShow? {
        return dataSource?.items[indexPath.row]
    }

    private func registerCells() {
        tableView.register(UINib(nibName: TVShowViewCell.identifier, bundle: nil), forCellReuseIdentifier: TVShowViewCell.identifier)
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:TVShowViewCell.identifier, for: indexPath) as! TVShowViewCell
        guard let tvShow = tvShow(for: indexPath) else { return cell }
        cell.configure(with: tvShow)
        return cell
    }

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemsCount = dataSource?.items.count else { return 0 }
        return itemsCount
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! TVShowDetialsViewController
        controller.tvShow = sender as? TvShow
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tvShow = tvShow(for: indexPath) else { return }
        performSegue(withIdentifier: "PopularToDetails", sender: tvShow)
    }
}
