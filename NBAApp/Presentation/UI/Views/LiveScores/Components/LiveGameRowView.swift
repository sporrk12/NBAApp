//
//  LiveGameRowView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 13/03/25.
//

import SwiftUI

struct LiveGameRowView: View {
    
    let game: EventModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
        
            
            HStack {
                if let competition = game.competitions.items.first {
                    ForEach(competition.competitors.items, id: \.team.id) { team in
                        CompetitorView(team: team, status: self.game.status.type.typeCategory)
                    }
                }
            }
            
            switch self.game.status.type.typeCategory {
            case .pre:
                Text(self.game.date.convertUTCtoCSTTime() ?? "")
                
            case .inProgress, .final, .finalQuarter:
                Text(self.game.status.type.detail)
                
            default:
                Text("")
                
            }
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}

#Preview {
    LiveGameRowView(game: EventModel(
        id: "401705520",
        date: "2025-03-13T23:00Z",
        name: "Washington Wizards at Detroit Pistons",
        shortName: "WSH @ DET",
        competitions: .init(
            count: 1,
            items: [CompetitionModel(
                venue: VenueModel(
                    id: "5404",
                    fullName: "Little Caesars Arena",
                    address: AddressModel(
                        city: "Detroit",
                        state: "MI"
                    )
                ),
                competitors: .init(
                    count: 2,
                    items: [CompetitorModel(
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
                        records: .defaultValue
                    ), CompetitorModel(
                        id: "27",
                        homeAway: "away",
                        winner: false,
                        team: TeamModel(
                            id: "27",
                            location: "Washington",
                            name: "Wizards",
                            abbreviation: "WSH",
                            displayName: "Washington Wizards",
                            shortDisplayName: "Wizards",
                            color: "e31837",
                            alternateColor: "002b5c",
                            isActive: true,
                            logo: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/wsh.png"
                        ),
                        score: "0",
                        lineScores: .defaultValue,
                        statistics: .defaultValue,
                        leaders: .defaultValue,
                        records: .defaultValue)
                    ]
                ),
                status: .defaultValue,
                highlights: .defaultValue,
                headlines: .defaultValue)]
        ),
        status: StatusModel(
            displayClock: "0.0",
            period: 0,
            type: TypeModel(
                id: "1",
                name: "STATUS_SCHEDULED",
                state: "pre",
                completed: false,
                description: "Scheduled",
                detail: "Thu, March 13th at 7:00 PM EDT",
                shortDetail: "3/13 - 7:00 PM EDT",
                abbreviation: "PT"
            )
        )
    ))
}

