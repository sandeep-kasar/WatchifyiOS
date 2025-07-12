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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
