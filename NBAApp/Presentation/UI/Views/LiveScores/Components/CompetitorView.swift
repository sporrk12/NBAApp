//
//  CompetitorView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/03/25.
//

import SwiftUI
import SDWebImageSwiftUI


struct CompetitorView: View {
    let team: CompetitorModel
    let status: StatusTypeCategory
    
    var body: some View {
        VStack {
            WebImage(
                url: URL(string: team.team.logo)
            )
            .resizable()
            .frame(width: 80, height: 80)
            
            Spacer()
            
            Text(team.team.displayName)
                .font(Font(Fonts.body1.medium500))
                
            Spacer()
            
            switch status {
            case .pre:
                Text(team.records.items.first?.summary ?? "")
                    .font(Font(Fonts.h4.medium500))
                   
   
               
                
            case .final, .finalQuarter, .inProgress, .halftime:
                Text(team.score)
                    .font(Font(Fonts.h2.semibold600))
                   
                
                
            case .unknown:
                EmptyView()
                
 
            }
                
        }
        .foregroundStyle(Color.white)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CompetitorView(
        team:CompetitorModel(
            id: "8",
            homeAway: "home",
            winner: false,
            team: TeamModel(
                id: "8",
                location: "Detriot",
                name: "Pistons",
                abbreviation: "DET",
                displayName: "Detroit Pistons",
                shortDisplayName: "Pistons",
                color: "1d428a",
                alternateColor: "c8102e",
                isActive: true,
                logo: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/det.png"
            ),
            score: "0",
            lineScores: .defaultValue,
            statistics: .defaultValue,
            leaders: .defaultValue,
            records: .init(
                count: 3,
                items: [RecordModel(
                    name: "overall",
                    abbreviation: "Total",
                    type: "total",
                    summary: "36-28"
                )]
            )
        ), status: StatusTypeCategory(id: "1")
    )
    .frame(width: 400, height: 100)
}

