//
//  SNetwork.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 30.06.2022.
//

import Foundation

class GenericNetworkService {
    private var dataTask: URLSessionDataTask?
    
    func fetch<T: Codable>(url: URL,
                           params: [String: String]? = nil,
                           completion: @escaping (Result<T, MovieError>) -> ()) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }

        var queryItems = [URLQueryItem(name: "api_key", value: Constants.APIConstants.APIKey)]
        
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }

        urlComponents.queryItems = queryItems

        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        dataTask = URLSession.shared.dataTask(with: finalURL) { [weak self] (data, response, error) in
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
                let decodedResponse = try JSONDecoder.jsonDecoder.decode(T.self, from: data)
                //print(decodedResponse)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }
        dataTask?.resume()
    }
    
    private func executeCompletionHandlerInMainThread<T: Codable>(with result: Result<T, MovieError>, completion: @escaping (Result<T, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
