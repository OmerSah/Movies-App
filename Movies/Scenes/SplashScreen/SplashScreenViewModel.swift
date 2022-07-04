//
//  SplashScreenViewModel.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 30.06.2022.
//

import Foundation
import UIKit

final class SplashScreenViewModel {
    weak var input: SplashScreenInput?
    weak var output: SplashScreenOutput?
    
    init() { input = self }
    
    private func setBookmarkedMovies() {
        let app = AppManager.shared
        let bookmark = BookmarkService.shared
        app.movies = bookmark.updateBookmarkedMovies(in: app.movies)
    }
}

extension SplashScreenViewModel: SplashScreenInput {
    func viewDidLoad() {
        // To make a delay (independent from fetching process)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            MovieService.shared.fetchGenres { (result) in
                switch result {
                case .success(let response):
                    AppManager.shared.genres = response.genres
                case .failure(let error):
                    self.output?.showError(error: error)
                    return
                }
            }
            
            var count = 0
            let endpoints = MovieListEndpoint.allCases
            
            for endpoint in endpoints {
                MovieService.shared.fetchMovies(from: endpoint) { [weak self] (result) in
                    guard let self = self else { return }
                    switch result {
                    case .success(let response):
                        AppManager.shared.movies[endpoint] = response.results
                        count += 1
                        if count == endpoints.count {
                            self.setBookmarkedMovies()
                            self.output?.createTabBar()
                        }
                    case .failure(let error):
                        self.output?.showError(error: error)
                        return
                    }
                }
            }
        }
    }
}
