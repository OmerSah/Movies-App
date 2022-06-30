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
}

extension SplashScreenViewModel: SplashScreenInput {
    func viewDidLoad() {
        var count = 0
        let endpointCount = MovieListEndpoint.allCases.count
        for endpoint in MovieListEndpoint.allCases {
            MovieService.shared.fetchMovies(from: endpoint) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    AppManager.shared.movies[endpoint] = response.results
                    count += 1
                    if count == endpointCount {
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
