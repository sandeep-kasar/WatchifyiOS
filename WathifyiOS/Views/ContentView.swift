//
//  ContentView.swift
//  WatchifyiOS
//
//  Created by Sandeep Kasar  on 06/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "list.bullet")
                }

            FavouritesView()
                .tabItem {
                    Label("Favourites", systemImage: "star.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "person.crop.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
