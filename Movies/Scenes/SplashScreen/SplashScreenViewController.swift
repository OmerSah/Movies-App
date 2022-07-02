//
//  SplashScreenViewController.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 27.06.2022.
//

import UIKit

class SplashScreenViewController: UIViewController {
    private let viewModel: SplashScreenViewModel
    
    init(viewModel: SplashScreenViewModel = .init()) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.input?.viewDidLoad()
    }
}

extension SplashScreenViewController: SplashScreenOutput {
    func createTabBar() {
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
    
    func showError(error: NetworkError) {
        print(error.localizedDescription)
    }
}
