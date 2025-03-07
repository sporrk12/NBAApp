//
//  GameScoreView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 30/01/25.
//

import SwiftUI

struct GameScoreView: View {
    
    var game: GameLogModel
    
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(game.date)")
                .font(.headline)
            HStack{
                HStack {
                    AsyncImage(url: URL(string: game.homeTeamLogo)) { image in
                        image.resizable().frame(width: 60, height: 60)
                    } placeholder: {
                        ProgressView()
                    }
                    Text("vs")
                    AsyncImage(url: URL(string: game.awayTeamLogo)) { image in
                        image.resizable().frame(width: 60, height: 60)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Spacer()
                VStack(alignment: .leading) {
                    Group{
                        Text("Puntos: ")
                            .bold()
                        +
                        Text("\(Int(game.points))")
                    }
                    
                    Group{
                        Text("Rebotes: ")
                            .bold()
                        +
                        Text("\(Int(game.rebounds))")
                    }
                    
                    Group{
                        Text("Asistencias: ")
                            .bold()
                        +
                        Text("\(Int(game.assists))")
                    }
                }
            }
        }
    }
}

#Preview {
    GameScoreView(game: GameLogModel(date: "fecbrero", points: 21, rebounds: 654, assists: 76, homeTeam: "Lakers", awayTeam: "Timberwolfs", homeTeamLogo: "https://a.espncdn.com/i/teamlogos/nba/500/NYK.png", awayTeamLogo: "https://a.espncdn.com/i/teamlogos/nba/500/NYK.png"))
}
