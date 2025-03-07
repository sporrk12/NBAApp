//
//  BoxScoreView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 28/01/25.
//

import SwiftUI


struct BoxScoreView: View {
    @State private var boxscore: BoxScoreModel?
    @State private var isLoading: Bool = true
    @State private var errorMessage: String?
    let gameID: String

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Cargando Boxscore...")
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                } else if let boxscore = boxscore {
                    VStack {
                        Text("\(boxscore.homeTeam.name) vs \(boxscore.awayTeam.name)")
                            .font(.headline)

                        List {
                            Section(header: Text("\(boxscore.homeTeam.name)")) {
                                ForEach(boxscore.homeTeam.players!, id: \.id) { player in
                                    PlayerRow(player: player)
                                }
                            }

                            Section(header: Text("\(boxscore.awayTeam.name)")) {
                                ForEach(boxscore.awayTeam.players!, id: \.id) { player in
                                    PlayerRow(player: player)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Boxscore")
            .onAppear {
                loadBoxscore()
            }
        }
    }

    private func loadBoxscore() {
        NBAService.shared.fetchBoxscore(for: gameID) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedBoxscore):
                    boxscore = fetchedBoxscore
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    print(error)
                }
            }
        }
    }
}

#Preview {
    BoxScoreView(gameID: "0022400636")
}
