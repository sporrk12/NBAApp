//
//  GameView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 28/01/25.
//

import SwiftUI

struct GameView: View {
    var game: GameModel
    
    var body: some View {
        VStack{
            HStack{
                
                TeamRowView(team: self.game.homeTeam, score: game.homeTeam.score!)
                
                Spacer()
                
                TeamRowView(team: self.game.awayTeam, score: self.game.awayTeam.score!)
                
                
                Image(systemName: "chevron.right")
                
            }
            Text(self.game.status)
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
    }
}

#Preview {
    GameView(game: GameModel(id: "2324324", date: "123312", status: "final", homeTeam: TeamModel(id: 123, name: "Lakers", abbreviation: "LAL", city: "Loa Angeles", logoURL: "https://a.espncdn.com/i/teamlogos/nba/500/NYK.png", score: 123, players: []), awayTeam: TeamModel(id: 123, name: "Lakers", abbreviation: "LAL", city: "Loa Angeles", logoURL: "https://a.espncdn.com/i/teamlogos/nba/500/NYK.png", score: 123, players: [])))
}
