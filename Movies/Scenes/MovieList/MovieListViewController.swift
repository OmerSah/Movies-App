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
        table.register(MovieListCell.self, forCellReuseIdentifier: Constants.UIConstants.movieListCellID)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 288
        return table
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.UIConstants.searchBarPlaceholder
        definesPresentationContext = true
        return searchController
    }()
    
    private lazy var categoriesMenu: UIMenu = .init(menuTitle: Constants.UIConstants.categoriesMenuTitle, titles: viewModel.genres,
                                                    handler: { self.viewModel.categoriesMenuHandler(title: $0) })
    
    private let viewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.output = self
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func configure() {
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.UIConstants.categoryMenuImage),
                                                            menu: categoriesMenu)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.UIConstants.movieListTitle
        
        view.addSubview(tableView)
        tableView.pin(to: view)
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

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.searchMovie(title: searchBar.text!)
    }
}

extension MovieListViewController: MovieListOutput {
    func refresh() {
        tableView.reloadData()
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIConstants.movieListCellID,
                                                       for: indexPath) as? MovieListCell
                                                       else { return MovieListCell() }
        
        cell.setMovie(movie: viewModel.movieForCell(filterStatus: isFiltering,
                                                    section: indexPath.section,
                                                    index: indexPath.row))
        
        cell.bookmarkAction = { self.viewModel.bookmarkButtonAction(filterStatus: self.isFiltering,
                                                                          section: indexPath.section,
                                                                          index: indexPath.row) }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
