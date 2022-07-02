//
//  BookMarksViewModel.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 27.06.2022.
//

import Foundation

final class BookmarksViewModel {
    private(set) var favouriteMovies = [Movie]()
    
    init() {
        getMoviesFromUserDefaults()
    }
    
    func getMoviesFromUserDefaults() {
        favouriteMovies = UserDefaultsManager.shared.get(key: Constants.UserDefaultConstants.favouritesKey)
    }
}
