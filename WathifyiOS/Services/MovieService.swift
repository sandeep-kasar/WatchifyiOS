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

    func fetchNowPlaying(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let parameters: Parameters = [
            "api_key": apiKey,
            "page": page
        ]

        AF.request(baseURL, parameters: parameters)
            .validate()
            .responseDecodable(of: NowPlayingResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}





