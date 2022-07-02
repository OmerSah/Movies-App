//
//  MovieListViewController.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 26.06.2022.
//

import UIKit

class MovieListViewController: UIViewController {

    private lazy var tableView: UITableView = {
        var table = UITableView()
        table.register(MovieListCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 288
        return table
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies..."
        definesPresentationContext = true
        return searchController
    }()
    
    private let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Movies"
        
        viewModel.output = self

        configure()
    }
    
    private func configure() {
        view.addSubview(tableView)
        tableView.pin(to: view)
        navigationItem.searchController = searchController
    }
}

// MARK: Implement filter control methods
extension MovieListViewController {
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text!.isEmpty
    }
    private var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
}

// MARK: Conform UISearchController methods
extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.searchMovie(title: searchBar.text!)
    }
}

// MARK: Conform MovieListOutput methods
extension MovieListViewController: MovieListOutput {
    func refresh() {
        tableView.reloadData()
    }
}

// MARK: Conform UITableView delegate methods
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieListCell else { return MovieListCell() }
        
        cell.setMovie(movie: viewModel.movieForCell(filterStatus: isFiltering,
                                                    section: indexPath.section,
                                                    index: indexPath.row))
        cell.bookmarkButtonAction = {
            self.viewModel.bookmarkButtonAction(section: indexPath.section, index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(filterStatus: isFiltering, section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieListEndpoint.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(filterStatus: isFiltering, section: section)
    }
}
