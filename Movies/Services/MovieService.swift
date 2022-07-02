//
//  MovieService.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 28.06.2022.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovies(from endpoint: MovieListEndpoint,completion: @escaping (Result<MovieResponse, NetworkError>) -> ())
    func fetchGenres(completion: @escaping (Result<GenreResponse, NetworkError>) -> ())
}

class MovieService: MovieServiceProtocol {
    static let shared = MovieService()
    private init() {}
        
    private let movieFetchURL = Constants.APIConstants.baseAPIURL + "/movie"
    private let genreFetchURL = Constants.APIConstants.baseAPIURL + "/genre/movie/list"
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, NetworkError>) -> ()) {
        guard let url = URL(string: "\(movieFetchURL)/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        ServiceManager.shared.fetch(url: url, params: [
            "language": "en-US",
            "page": "1",
            "include_adult": "false"
        ], completion: completion)
    }
    
    func fetchGenres(completion: @escaping (Result<GenreResponse, NetworkError>) -> ()) {
        guard let url = URL(string: genreFetchURL) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        ServiceManager.shared.fetch(url: url, params: [
            "language": "en-US",
        ], completion: completion)
    }
}
