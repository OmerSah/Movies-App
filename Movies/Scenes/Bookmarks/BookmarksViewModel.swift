//
//  BookMarksViewModel.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 27.06.2022.
//

import Foundation

final class BookmarksViewModel {
    private(set) var bookmarkedMovies = [Movie]()
    private let endpoints = MovieListEndpoint.allCases
    private let bookmarkService = BookmarkService.shared
    
    weak var input: BookmarksInput?
    weak var output: BookmarksOutput?
    
    init() { input = self }
    
    func getMoviesFromUserDefaults() {
        bookmarkedMovies = bookmarkService.getBookmarkedMovies()
    }
    
    func deleteBookmarkedMovie(index: Int) {
        let movie = bookmarkedMovies[index]
        bookmarkedMovies = bookmarkedMovies.filter( { $0.id != movie.id } )
        bookmarkService.setBookmarkedMovies(movies: bookmarkedMovies)
    }
}

extension BookmarksViewModel: BookmarksInput {
    func viewWillAppear() {
        getMoviesFromUserDefaults()
        output?.refresh()
    }
}
