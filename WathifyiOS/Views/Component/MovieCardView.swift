//
//  MovieCardView.swift
//  WathifyiOS
//
//  Created by Sandeep Popat Kasar on 12/07/25.
//

import SwiftUI

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

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(movie: Movie(
            id:1,
            title: "Inception",
            overview: "A thief who steals corporate secrets through dream-sharing technology is given a task to plant an idea.",
            posterPath: "/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg"
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

