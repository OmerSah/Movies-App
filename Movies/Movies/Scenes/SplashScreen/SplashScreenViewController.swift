//
//  SplashScreenViewController.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 27.06.2022.
//

import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        MovieService.shared.getPopularMoviesData { (result) in
            switch result {
            case .success(let response):
                Movies.shared.movies = response.results
                self.configureTabBar()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
        
    private func configureTabBar() {
        let tabBarController = UITabBarController()
        
        let movieList = UINavigationController(rootViewController: MovieListViewController())
        let bookmarks = UINavigationController(rootViewController: BookmarksViewController())
        
        movieList.tabBarItem = UITabBarItem(title: "Home",
                                            image: UIImage(systemName: "house"),
                                            selectedImage: UIImage(systemName: "house.fill"))
        bookmarks.tabBarItem = UITabBarItem(title: "Bookmarks",
                                            image: UIImage(systemName: "bookmark"),
                                            selectedImage: UIImage(systemName: "bookmark.fill"))

        tabBarController.setViewControllers([movieList,bookmarks], animated: true)
        
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController,animated: true)
    }

}
