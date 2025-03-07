//
//  TeamsView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 30/01/25.
//

import SwiftUI

struct TeamsView: View {
    @State private var teams: [TeamModel] = []
    @State private var isLoading: Bool = true
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Cargando equipos...")
                } else {
                    List(teams, id: \.id) { team in
                        NavigationLink(destination: TeamPlayersView(team: team)) {
                            HStack {
                                Image(team.abbreviation)
                                    .resizable().frame(width: 40, height: 40)
                                Text(team.name)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Equipos de la NBA")
            .onAppear {
                loadTeams()
            }
        }
    }

    private func loadTeams() {
        NBAService.shared.fetchTeams { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let teams):
                    self.teams = teams
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
#Preview {
    TeamsView()
}
