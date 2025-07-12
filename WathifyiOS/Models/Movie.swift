//
//  Movie.swift
//  WatchifyiOS
//
//  Created by Sandeep Kasar  on 05/06/25.
//

import Foundation

struct NowPlayingResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
    }
}
