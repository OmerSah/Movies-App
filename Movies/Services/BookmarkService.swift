//
//  BookmarkService.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 4.07.2022.
//

import Foundation

class BookmarkService {
    static let shared = BookmarkService()
    private init() {}
    
    private let key = Constants.UserDefaultConstants.favouritesKey
    
    func getBookmarkedMovies() -> [Movie] {
        return UserDefaultsManager.shared.get(key: key)
    }
    
    func setBookmarkedMovies(movies: [Movie]) {
        UserDefaultsManager.shared.set(items: movies, key: key)
    }
    
    func updateBookmarkedMovies(in movies: [MovieListEndpoint: [Movie]]) -> [MovieListEndpoint: [Movie]] {
        let bookmarked = getBookmarkedMovies()
        
        var modifiedMovies = movies
        for endpoint in MovieListEndpoint.allCases {
            for i in 0..<(modifiedMovies[endpoint]?.count ?? 0) {
                modifiedMovies[endpoint]?[i].isFav = false
            }
        }
        
        for endpoint in MovieListEndpoint.allCases {
            for movie in bookmarked {
                for i in 0..<(modifiedMovies[endpoint]?.count ?? 0) {
                    if modifiedMovies[endpoint]?[i].id == movie.id {
                        modifiedMovies[endpoint]?[i].isFav = true
                    }
                }
            }
        }
        return modifiedMovies
    }
}
