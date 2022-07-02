//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 26.06.2022.
//

import Foundation

final class MovieListViewModel {
    
    weak var output: MovieListOutput?
    weak var input: MovieListInput?
    
    private(set) var filteredMovies = [MovieListEndpoint: [Movie]]()
    
    init() { input = self }
    
    func searchMovie(title: String) {
        filteredMovies = [MovieListEndpoint: [Movie]]()
        for endpoint in MovieListEndpoint.allCases {
            filteredMovies[endpoint] = [Movie]()
            filteredMovies[endpoint] = AppManager.shared.movies[endpoint]?.filter( { $0.title.lowercased().contains(title.lowercased()) } )
            print(filteredMovies[endpoint]!.map({ $0.title }))
        }
        output?.refresh()
    }
    
    func movieForCell(filterStatus: Bool, section: Int, index: Int) -> Movie? {
        let movie: Movie?
        if filterStatus {
            movie = filteredMovies[MovieListEndpoint.allCases[section]]?[index]
        } else {
            movie = AppManager.shared.movies[MovieListEndpoint.allCases[section]]?[index]
        }
        return movie
    }
}

extension MovieListViewModel: MovieListInput {
    func bookmarkButtonAction(section: Int, index: Int) {
        guard let movie = AppManager.shared.movies[MovieListEndpoint.allCases[section]]?[index] else { return }
        var movies: [Movie] = UserDefaultsManager.shared.get(key: Constants.UserDefaultConstants.favouritesKey)
        AppManager.shared.movies[MovieListEndpoint.allCases[section]]![index].isFav = !movie.isFav
                                 
        if !movie.isFav  {
            if !movies.contains(movie) {
                movies = movies + [movie]
            }
            UserDefaultsManager.shared.set(items: movies,
                                           key: Constants.UserDefaultConstants.favouritesKey)
            
        } else {
            movies = movies.filter( { $0.id != movie.id } )
            UserDefaultsManager.shared.set(items: movies,
                                           key: Constants.UserDefaultConstants.favouritesKey)
        }
        output?.refresh()
    }
    
    func titleForHeaderInSection(filterStatus: Bool, section: Int) -> String {
        if filterStatus && filteredMovies[MovieListEndpoint.allCases[section]]?.count == 0 {
            return MovieListEndpoint.allCases[section].description + " (No Results Found)"
        }
        return MovieListEndpoint.allCases[section].description
    }
    
    func numberOfRowsInSection(filterStatus: Bool, section: Int) -> Int {
        if filterStatus {
            return filteredMovies[MovieListEndpoint.allCases[section]]?.count ?? 0
        }
        return AppManager.shared.movies[MovieListEndpoint.allCases[section]]?.count ?? 0
    }
}
