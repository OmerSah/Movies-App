//
//  BookmarksViewController.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 27.06.2022.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        var table = UITableView()
        table.register(MovieListCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 288
        return table
    }()
    
    private let viewModel = BookmarksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Bookmarks"
        
        configure()
    }
    
    private func configure() {
        view.addSubview(tableView)
        tableView.pin(to: view)
    }
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieListCell else { return MovieListCell() }
        //cell.setMovie(movie: )
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
