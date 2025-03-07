//
//  TeamRowView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 24/01/25.
//

import SwiftUI

struct TeamRowView: View {
    let team: TeamModel
    let score: Int
    
    var body: some View {
        VStack(alignment: .center){
            Image(team.abbreviation)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
            
            Text("\(team.name)")
                .multilineTextAlignment(.center)
                .font(.headline)
                .padding(.bottom, 8)
                .frame(width: 110)
            Text("\(score)")
                .font(.title)
            
        }
        .foregroundStyle(.white)
        
    }
}

#Preview {
    TeamRowView(team: TeamModel(id: 123, name: "Golden State Warriors", abbreviation: "LAL", city: "Loa Angeles", logoURL: "https://a.espncdn.com/i/teamlogos/nba/500/NYK.png", score: 123, players: []), score: 35436)
}
