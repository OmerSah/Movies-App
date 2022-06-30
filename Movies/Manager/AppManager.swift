//
//  AppManager.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 30.06.2022.
//

import Foundation
 
class AppManager {
    static let shared = AppManager()
    
    var movies = [MovieListEndpoint: [Movie]]()
    
    private init() {
        for endpoint in MovieListEndpoint.allCases {
            movies[endpoint] = [Movie]()
        }
    }
}
