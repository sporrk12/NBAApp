//
//  PlayerDetailView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 30/01/25.
//

import Foundation

import SwiftUI

struct PlayerDetailView: View {
    let player: PlayerModel
    @State private var careerStats: [CareerStatsModel] = []
    @State private var last5Games: [GameLogModel] = []
    @State private var isLoading = true

    var body: some View {
        
        ScrollView(showsIndicators: false){
            VStack {
                if isLoading {
                    ProgressView("Cargando datos...")
                } else {
                    
                    ForEach(last5Games, id: \.date){ game in
                        GameScoreView(game: game)
                        Divider()
                            .background(Color.teal)
                
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(player.name)
        .foregroundStyle(Color.white)
        .onAppear {
            loadPlayerData()
        }
    }

    private func loadPlayerData() {
        isLoading = true
        let group = DispatchGroup()

        group.enter()
        NBAService.shared.fetchLast5Games(playerID: player.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let games):
                    self.last5Games = games
                case .failure(let error):
                    print("Error cargando últimos juegos: \(error)")
                    print(error)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.isLoading = false
        }
    }
}

#Preview {
    PlayerDetailView(player: PlayerModel(id: 203076, name: "", height: "", weight: "", position: "", points: 0, rebounds: 0, assists: 0, imageURL: ""))
}
