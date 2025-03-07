//
//  TeamPlayersView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 30/01/25.
//

import SwiftUI

import SwiftUI

struct TeamPlayersView: View {
    let team: TeamModel
    @State private var players: [PlayerModel] = []
    @State private var isLoading: Bool = true
    @State private var errorMessage: String?
    
    var body: some View {
        ZStack{
            team.primaryColor.ignoresSafeArea()
                .opacity(0.3)
            
            VStack {
                if isLoading {
                    ProgressView("Cargando jugadores...")
                } else {
                    List(players, id: \.id) { player in
                        NavigationLink(destination: PlayerDetailView(player: player)) {
                            HStack {
                                AsyncImage(url: URL(string: player.imageURL ?? "")) { image in
                                    image.resizable().frame(width: 100, height: 80)
                                } placeholder: {
                                    ProgressView()
                                }
                                VStack(alignment: .leading) {
                                    Text(player.name)
                                        .font(.headline)
                                        .foregroundStyle(Color.black)
                                    Text(player.position ?? "Sin posición")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                        }
                        .listRowBackground(team.primaryColor) .cornerRadius(10)
                    }
                    .background(team.primaryColor)
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .navigationTitle(team.name)
        .onAppear {
            loadPlayers()
        }
    }
    
    private func loadPlayers() {
        NBAService.shared.fetchPlayers(for: team.id) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let players):
                    self.players = players
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    TeamPlayersView(team: TeamModel(id: 123, name: "Golden State Warriors", abbreviation: "LAL", city: "Loa Angeles", logoURL: "https://a.espncdn.com/i/teamlogos/nba/500/NYK.png", score: 123, players: [PlayerModel(id: 1, name: "Luis", height: "", weight: "", position: "", points: 12, rebounds: 12, assists: 12, imageURL: "")]))
}
