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
        searchViewModel.willFinishSearch()
    }
    
    func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = K.UI.searchPlaceholder
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = searchViewModel.modelFor(indexPath: indexPath)
        CoreData.shared.insert(CityCoreDataModel.self, responseModel: selectedModel)
        performSegue(withIdentifier: K.Storyboard.Search.showDetail, sender: selectedModel)
    }
}

// MARK: - UISearchResultsUpdating, UISearchControllerDelegate
extension SearchCityTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let string = searchController.searchBar.text, !string.isEmpty else {
            return
        }
        searchViewModel.searchFor(string)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        searchViewModel.willFinishSearch()
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchViewModel.willStartSearch()
    }
}

//MARK: Navigation
extension SearchCityTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? CityDataModel, let destin = segue.destination as? CityDetailViewController {
            destin.cityDataModel = sender
        }
    }
}
