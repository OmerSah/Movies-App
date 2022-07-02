//
//  MovieArray.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 28.06.2022.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct GenreResponse: Codable {
    let genres: [Genre]
}
