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
        table.register(BookmarksCell.self, forCellReuseIdentifier: Constants.UIConstants.bookmarksCellID)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 288
        return table
    }()
    
    private let viewModel = BookmarksViewModel()
    
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
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.UIConstants.bookmarksTitle
        
        tableView.pin(to: view)
    }
}

extension BookmarksViewController: BookmarksOutput {
    func refresh() {
        tableView.reloadData()
    }
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UIConstants.bookmarksCellID,
                                                       for: indexPath) as? BookmarksCell else { return BookmarksCell() }
        cell.setMovie(movie: viewModel.bookmarkedMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookmarkedMovies.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteBookmarkedMovie(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
