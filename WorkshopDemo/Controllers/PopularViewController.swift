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
        tableView.tableFooterView = UIView()
        loadPopular()
    }

    private func loadPopular() {
        service.fetchPopular() { [weak self] dataSource in
            self?.dataSource = dataSource
            self?.tableView.reloadData()
        }
    }

    private func tvShow(for indexPath: IndexPath) -> TvShow? {
        return dataSource?.items[indexPath.row]
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"DefaultCell", for: indexPath)
        guard let tvShow = tvShow(for: indexPath) else { return cell }
        cell.textLabel?.text = tvShow.name
        cell.detailTextLabel?.text = "Rating: \(String(format: "%.1f", tvShow.rating))"
        return cell
    }

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemsCount = dataSource?.items.count else { return 0 }
        return itemsCount
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tvShow = tvShow(for: indexPath) else { return }

        let alertController = UIAlertController(title: tvShow.name, message: tvShow.overview, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
