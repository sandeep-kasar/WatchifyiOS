//
//  MovieViewModel.swift
//  WatchifyiOS
//
//  Created by Sandeep Kasar  on 05/06/25.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?

    private let movieService = MovieService()

    func loadNowPlaying() {
        movieService.fetchNowPlaying { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
