//
//  MovieService.swift
//  WatchifyiOS
//
//  Created by Sandeep Kasar  on 05/06/25.
//

import Foundation
import Alamofire

class MovieService {
    private let baseURL = "https://api.themoviedb.org/3/movie/now_playing"
    private let apiKey = Constants.apiKey

    func fetchNowPlaying(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let parameters: Parameters = [
            "api_key": apiKey
        ]

        AF.request(baseURL, parameters: parameters)
            .validate() // Automatically checks for 200...299 status codes
            .responseDecodable(of: NowPlayingResponse.self) { response in
                switch response.result {
                case .success(let nowPlaying):
                    completion(.success(nowPlaying.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}



