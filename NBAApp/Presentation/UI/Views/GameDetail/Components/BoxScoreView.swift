//
//  BoxScoreView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 18/03/25.
//

import SwiftUI

struct BoxscoreView: View {
    let boxscore: BoxScoreModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Boxscore")
                .font(.title2)
                .bold()
            
            ForEach(boxscore.teams.items, id: \.team.id) { team in
                VStack(alignment: .leading, spacing: 10) {
                    Text(team.team.displayName)
                        .font(.headline)
                        .foregroundColor(.blue)

                    ForEach(team.statistics.items, id: \.name) { stat in
                        HStack {
                            Text(stat.label)
                                .frame(width: 150, alignment: .leading)
                            Text(stat.displayValue)
                                .bold()
                        }
                    }
                }
                .padding(.vertical, 5)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

#Preview {
    BoxscoreView(boxscore: BoxScoreModel(
        teams: .defaultValue,
        players: .defaultValue))
}
