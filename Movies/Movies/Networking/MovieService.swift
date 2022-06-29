//
//  MovieService.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 28.06.2022.
//

import Foundation

class MovieService {
    static let shared = MovieService()
    private init() {}
    
    private let apiKey = "69628a972676cbc7c395c6a05abd700e"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    
    private var dataTask: URLSessionDataTask?
    
    func getPopularMoviesData(completion: @escaping (Result<Response, MovieError>) -> ()) {
        guard let popularMoviesURL = URL(string: "\(baseAPIURL)/movie/\(MovieListEndpoint.popular.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }

        guard var urlComponents = URLComponents(url: popularMoviesURL, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }

        var queryItems = [URLQueryItem]()

        let params: [String: String] = [
            "api_key": apiKey,
            "language": "en-US",
            "page": "1",
            "include_adult": "false",
            "region": "US"
        ]

        queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }

            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }

            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder.jsonDecoder.decode(Response.self, from: data)
                print(decodedResponse)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }
        dataTask?.resume()
    }

    private func executeCompletionHandlerInMainThread(with result: Result<Response, MovieError>, completion: @escaping (Result<Response, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
