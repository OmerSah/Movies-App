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
    private var categorizedMovies = [MovieListEndpoint: [Movie]]()
    
    let genres = ["All"] + AppManager.shared.genres.map( { $0.name } )
    private var selectedGenreID = 0
    
    private let bookmarkService = BookmarkService.shared
    private let appManager = AppManager.shared
    private let endpoints = MovieListEndpoint.allCases
    private let userDefaults = UserDefaultsManager.shared
    
    init() {
        input = self
        categorizedMovies = appManager.movies
    }
    
    func searchMovie(title: String) {
        filteredMovies = [MovieListEndpoint: [Movie]]()
        for endpoint in endpoints {
            filteredMovies[endpoint] = [Movie]()
            filteredMovies[endpoint] = categorizedMovies[endpoint]?.filter( { $0.title.lowercased().contains(title.lowercased()) } )
        }
        output?.refresh()
    }
    
    func movieForCell(filterStatus: Bool, section: Int, index: Int) -> Movie? {
        let movie: Movie?
        if filterStatus {
            movie = filteredMovies[endpoints[section]]?[index]
        } else {
            movie = categorizedMovies[endpoints[section]]?[index]
        }
        return movie
    }
    
    func updateBookMarkedMovies() {
        filteredMovies = bookmarkService.updateBookmarkedMovies(in: filteredMovies)
        appManager.movies = bookmarkService.updateBookmarkedMovies(in: appManager.movies)
        updateCategorizedMovies()
    }
    
    func updateCategorizedMovies() {
        if selectedGenreID != 0 {
            for endpoint in endpoints {
                categorizedMovies[endpoint] = [Movie]()
                for movie in appManager.movies[endpoint] ?? [Movie]() {
                    if movie.genres.contains(where: { $0 == selectedGenreID } ) {
                        categorizedMovies[endpoint]? += [movie]
                    }
                }
            }
        } else {
            categorizedMovies = appManager.movies
        }
    }
    
}

extension MovieListViewModel: MovieListInput {
    func viewWillAppear() {
        updateBookMarkedMovies()
        output?.refresh()
    }
    
    func bookmarkButtonAction(filterStatus: Bool, section: Int, index: Int) {
        var movies: [Movie] = bookmarkService.getBookmarkedMovies()
        
        guard let movie = movieForCell(filterStatus: filterStatus, section: section, index: index)
            else { return }
        
        if !movie.isFav  {
            if !movies.contains(where: { $0.id == movie.id }) {
                movies = movies + [movie]
            }
            bookmarkService.setBookmarkedMovies(movies: movies)
        } else {
            movies = movies.filter( { $0.id != movie.id } )
            bookmarkService.setBookmarkedMovies(movies: movies)
        }
        
        updateBookMarkedMovies()
        output?.refresh()
    }
    
    func titleForHeaderInSection(filterStatus: Bool, section: Int) -> String {
        if categorizedMovies[endpoints[section]]?.count == 0
            || (filterStatus &&  filteredMovies[endpoints[section]]?.count == 0) {
            return endpoints[section].description + " (No Results Found)"
        }
        return endpoints[section].description
    }
    
    func numberOfRowsInSection(filterStatus: Bool, section: Int) -> Int {
        if filterStatus {
            return filteredMovies[endpoints[section]]?.count ?? 0
        }
        return categorizedMovies[endpoints[section]]?.count ?? 0
    }
    
    func categoriesMenuHandler(title: String) {
        selectedGenreID = appManager.genres.filter( { $0.name == title } ).first?.id ?? 0
        updateCategorizedMovies()
        output?.refresh()
    }
}
