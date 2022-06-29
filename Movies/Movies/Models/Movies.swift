//
//  Movies.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 28.06.2022.
//

import Foundation

class Movies {
    static let shared = Movies()
    
    var movies = [Movie]()
    
    private init() {}
}
