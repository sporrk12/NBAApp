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
            LiveScoresView()
                .tabItem {
                    VStack {
                        Image(systemName: "basketball.fill")
                            .foregroundStyle(.tint)
                        Text("Live")
                            .foregroundStyle(.tint)
                    }
                }
        }
    }
}
#Preview {
    ContentView()
}
