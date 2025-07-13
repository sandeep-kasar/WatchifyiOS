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
    @Published var isLoading = false

    private let movieService = MovieService()
    private var currentPage = 1
    private var canLoadMore = true

    func loadNowPlaying() {
        guard !isLoading && canLoadMore else { return }

        isLoading = true

        movieService.fetchNowPlaying(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false

                switch result {
                case .success(let newMovies):
                    if newMovies.isEmpty {
                        self.canLoadMore = false
                    } else {
                        self.movies.append(contentsOf: newMovies)
                        self.currentPage += 1
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

