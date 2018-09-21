//
//  SearchViewController.swift
//  WorkshopDemo
//
//  Created by Hrvoje Stanisic on 20.09.18.
//  Copyright © 2018 WomenInTech. All rights reserved.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private let service = TvShowService()
    private var dataSource: TvShowResult?

    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    private func tvShow(for indexPath: IndexPath) -> TvShow? {
        return dataSource?.items[indexPath.row]
    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        service.search(withQuery: query) {  [weak self] dataSource in
            self?.dataSource = dataSource
            self?.tableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            dataSource = nil
            tableView.reloadData()
            searchBar.resignFirstResponder()
        }
    }
}

extension SearchViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"DefaultCell", for: indexPath)
        guard let tvShow = tvShow(for: indexPath) else { return cell }
        cell.textLabel?.text = tvShow.name
        cell.detailTextLabel?.text = "Rating: \(String(format: "%.1f", tvShow.rating))"
        return cell
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemsCount = dataSource?.items.count else { return 0 }
        return itemsCount
    }
}

extension SearchViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tvShow = tvShow(for: indexPath) else { return }

        let alertController = UIAlertController(title: tvShow.name, message: tvShow.overview, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
