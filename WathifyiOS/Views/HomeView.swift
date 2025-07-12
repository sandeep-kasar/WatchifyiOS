//
//  MovieListView.swift
//  WatchifyiOS
//
//  Created by Sandeep Kasar on 05/06/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = MovieViewModel()
    @State private var searchText = ""

    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return viewModel.movies
        } else {
            return viewModel.movies.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Custom top bar with title and search
                HStack {
                    Text("Watchify")
                        .font(.title2)

                    Spacer()

                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .padding(.trailing)
                }
                .padding([.horizontal, .top])

                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredMovies) { movie in
                            MovieCardView(movie: movie)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
            .onAppear {
                viewModel.loadNowPlaying()
            }
        }
    }
}

struct MovieCardView: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(movie.posterPath ?? "")")) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 80, height: 120)
            .cornerRadius(10)
            .clipped()

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(4)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
