//
//  SearchCityTableViewController.swift
//  Weather
//
//  Created by bunty.madan on 20/8/19.
//  Copyright © 2019 Bunty Madan. All rights reserved.
//

import UIKit

class SearchCityTableViewController: UITableViewController {
    
    var searchViewModel = SearchViewModel(dataProvider: NetworkDataProvider())
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupBinding() {
        searchViewModel.results.bind {
            self.tableView.reloadData()
        }
    }
    
    func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: - Table view data source
extension SearchCityTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier, for: indexPath) as! CityTableViewCell
        cell.setupCell(searchViewModel.modelFor(indexPath: indexPath))
        return cell
    }
}

// MARK: - UISearchResultsUpdating, UISearchControllerDelegate
extension SearchCityTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchViewModel.searchFor(searchController.searchBar.text)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        searchViewModel.willFinishSearch()
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchViewModel.willStartSearch()
    }
}

