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
    
    private let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Movies"
        
        configure()
    }
    
    private func configure() {
        view.addSubview(tableView)
        tableView.pin(to: view)
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieListCell else { return MovieListCell() }
        cell.setMovie(movie: AppManager.shared.movies[.upcoming]?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppManager.shared.movies[.upcoming]?.count ?? 0
    }
}
