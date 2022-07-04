//
//  SplashScreenViewController.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 27.06.2022.
//

import UIKit
import SnapKit

class SplashScreenViewController: UIViewController {
    private let launchLabel: UILabel = .init(text: Constants.UIConstants.splashScreenTitle, font: UIFont.boldSystemFont(ofSize: 64))
    private let creatorLabel: UILabel = .init(text: Constants.UIConstants.creator, font: UIFont.systemFont(ofSize: 12), textColor: .lightGray)
    
    private let viewModel = SplashScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.output = self
        
        configure()
        makeAllConstraints()
        
        viewModel.input?.viewDidLoad()
    }
    
    private func configure() {
        view.addSubview(launchLabel)
        view.addSubview(creatorLabel)
    }
    
    private func makeAllConstraints() {
        launchLabel.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
        }
        creatorLabel.snp.makeConstraints {
            $0.top.equalTo(launchLabel.snp.bottom)
            $0.trailing.equalTo(launchLabel.snp.trailing)
        }
    }
}

extension SplashScreenViewController: SplashScreenOutput {
    func createTabBar() {
        let tabBarController = UITabBarController()
        
        let movieList = UINavigationController(rootViewController: MovieListViewController())
        let bookmarks = UINavigationController(rootViewController: BookmarksViewController())
        
        movieList.tabBarItem = UITabBarItem(title: Constants.UIConstants.homeTabBarTitle,
                                            image: UIImage(systemName: Constants.UIConstants.homeImage),
                                            selectedImage: UIImage(systemName: Constants.UIConstants.selectedHomeImage))
        
        bookmarks.tabBarItem = UITabBarItem(title: Constants.UIConstants.bookmarksTabBarTitle,
                                            image: UIImage(systemName: Constants.UIConstants.bookmarkImage),
                                            selectedImage: UIImage(systemName: Constants.UIConstants.selectedBookmarkImage))

        tabBarController.setViewControllers([movieList,bookmarks], animated: true)
        
        tabBarController.modalPresentationStyle = .fullScreen
        
        UIApplication.shared.windows.first?.rootViewController = tabBarController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        UIView.transition(with: UIApplication.shared.windows.first!, duration: 0.3, options: [.transitionCrossDissolve], animations: {}, completion: nil)
    }
    
    func showError(error: NetworkError) {
        let alert = UIAlertController(title: "Operation Failed!", message: error.localizedDescription,
                                           preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
}
