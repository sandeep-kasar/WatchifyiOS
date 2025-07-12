//
//  MovieService.swift
//  WatchifyiOS
//
//  Created by Sandeep Kasar  on 05/06/25.
//

import Foundation

class MovieService {
    private let baseURL = "https://api.themoviedb.org/3/movie/now_playing"
    private let apiKey = Constants.apiKey

    func fetchNowPlaying(completion: @escaping (Result<[Movie], Error>) -> Void) {
        // Construct the full URL with query parameters
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }

        // Create the request
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle network error
            if let error = error {
                completion(.failure(error))
                return
            }

            // Check for valid HTTP response and data
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let data = data else {
                completion(.failure(NSError(domain: "Invalid response", code: -2)))
                return
            }

            do {
                // Decode JSON into model
                let decoded = try JSONDecoder().decode(NowPlayingResponse.self, from: data)
                completion(.success(decoded.results))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}


