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
                // Top Bar
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
                        ForEach(filteredMovies.indices, id: \.self) { index in
                            let movie = filteredMovies[index]
                            MovieCardView(movie: movie)
                                .padding(.horizontal)
                                .onAppear {
                                    if searchText.isEmpty && index == filteredMovies.count - 1 {
                                        viewModel.loadNowPlaying()
                                    }
                                }
                        }

                        if viewModel.isLoading {
                            ProgressView("Loading...")
                                .padding()
                        }
                    }
                    .padding(.top)
                }
            }
            .onAppear {
                viewModel.loadNowPlaying()
            }
            .navigationBarHidden(true)
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
