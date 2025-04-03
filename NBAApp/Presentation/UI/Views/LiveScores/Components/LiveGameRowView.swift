//
//  LiveGameRowView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 13/03/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct LiveGameRowView: View {
    let game: EventModel
    
    var body: some View {
        ZStack {
            Color.black
            
            HStack(spacing: 0) {
                if let competition = game.competitions.items.first {
                    let teams = competition.competitors.items
                    
                    if teams.count == 2 {
                        let team1 = teams[0]
                        let team2 = teams[1]
                        
                        LogoView(imageURL: team1.team.logo, alignment: .leading)
                        
                        VStack(spacing: 6) {
                            HStack {
                                Text(team1.team.name)
                                Spacer()
                                Text(team2.team.name)
                            }
                            .font(.subheadline)
                            .foregroundColor(.white)
                            
                            
                            switch self.game.status.type.typeCategory {
                                
                            case .pre:
                                Text(self.game.date.convertUTCtoCSTTime() ?? "")
                                    .font(Font(Fonts.h2.medium500))
                                
                            case .inProgress, .final, .finalQuarter, .halftime, .unknown:
                                
                                HStack(spacing: 8) {
                                    Text(team1.score)
                                    Text("-")
                                    Text(team2.score)
                                }
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.white)
                                
                                Text(game.status.type.detail)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        LogoView(imageURL: team2.team.logo, alignment: .trailing)
                    }
                }
            }
        }
        .frame(height: 130)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 17))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white.opacity(0.1), lineWidth: 1))
        .padding(.horizontal)
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
                date: "432432432",
                venue: VenueModel(
                    id: "5404",
                    fullName: "Little Caesars Arena",
                    address: AddressModel(
                        city: "Detroit",
                        state: "MI"
                    ), image: "https://a.espncdn.com/i/venues/nba/day/516.jpg"
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
                            logo: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/det.png", logos: .defaultValue
                        ),
                        score: "23",
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
                            logo: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/wsh.png", logos: .defaultValue
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
                id: "2",
                name: "STATUS_SCHEDULED",
                state: "pre",
                completed: false,
                description: "Scheduled",
                detail: "1st 4 quarters",
                shortDetail: "3/13 - 7:00 PM EDT",
                abbreviation: "PT"
            )
        )
    ))
}

