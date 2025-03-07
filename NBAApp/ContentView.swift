//
//  ContentView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 24/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            LiveGamesView()
                .tabItem {
                    VStack {
                        Image(systemName: "basketball.fill")
                            .foregroundStyle(.tint)
                        Text("Live")
                            .foregroundStyle(.tint)
                    }
                }
            
            TeamsView()
                .tabItem {
                    VStack {
                        Image(systemName: "circle.grid.3x3")
                            .foregroundStyle(.tint)
                        Text("Teams")
                            .foregroundStyle(.tint)
                    }
                }
        }
    }
}
#Preview {
    ContentView()
}
