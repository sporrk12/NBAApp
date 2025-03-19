//
//  PredictorChartView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 17/03/25.
//

import SwiftUI
import Charts
import SDWebImageSwiftUI

struct PredictorChartView: View {
    let predictor: PredictorModel
    let teams: CountedListModel<TeamBoxScoreModel>
    
    var homeTeam: TeamBoxScoreModel {
        teams.items.first { $0.homeAway == "home" } ?? .defaultValue
    }
    
    var awayTeam: TeamBoxScoreModel {
        teams.items.first { $0.homeAway == "away"  } ?? .defaultValue
    }
    
    var homeWinChance: Double {
        Double(predictor.homeProjection) ?? 0.0
    }
    
    var awayWinChance: Double {
        Double(predictor.awayProjection) ?? 0.0
    }
    
    var data: [(team: String, chance: Double, color: Color, logo: String?)] {
        [
            (
                homeTeam.team.displayName,
                homeWinChance,
                Color(hex: homeTeam.team.color),
                homeTeam.team.logo
            ),
            (
                awayTeam.team.displayName,
                awayWinChance,
                Color(hex: awayTeam.team.alternateColor ),
                awayTeam.team.logo
            )
        ]
    }
    
    var body: some View {
        VStack {
            Text(predictor.header)
                .font(.title)
                .bold()
                .padding()
            
            ZStack {
                
                Chart(data, id: \.team) { entry in
                    SectorMark(
                        angle: .value("Win Chance", entry.chance),
                        innerRadius: .ratio(0.7),
                        angularInset: 2.0
                    )
                    .foregroundStyle(entry.color)
                }
                
                
                VStack{
                    HStack(spacing: 20) {
                        
                        VStack {
                            WebImage(
                                url: URL(string: awayTeam.team.logo)
                            )
                            .resizable()
                            .frame(width: 100, height: 100)
                            
                            Text("\(String(format: "%.1f", awayWinChance))%")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 2, height: 150)
                        
                        
                        VStack {
                            WebImage(
                                url: URL(string: homeTeam.team.logo)
                            )
                            .resizable()
                            .frame(width: 100, height: 100)
                            Text("\(String(format: "%.1f", homeWinChance))%")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PredictorChartView(
        predictor: PredictorModel(
            header: "Matchup Predictor",
            homeProjection: "13.7",
            awayProjection: "86.3"
        ),
        teams: .init(
            count: 2,
            items: [TeamBoxScoreModel(
                team:
                    TeamModel(
                        id: "18",
                        location: "New York",
                        name: "Knicks",
                        abbreviation: "NY",
                        displayName: "New York Knicks",
                        shortDisplayName: "Knicks",
                        color: "1d428a",
                        alternateColor: "f58426",
                        isActive: true,
                        logo: "https://a.espncdn.com/i/teamlogos/nba/500/ny.png"
                    ),
                statistics: .defaultValue,
                displayOrder: 1,
                homeAway: "away"
            ),TeamBoxScoreModel(
                team:
                    TeamModel(
                        id: "9",
                        location: "Golden State",
                        name: "Warriors",
                        abbreviation: "GS",
                        displayName: "Golden State Warriors",
                        shortDisplayName: "Warriors",
                        color: "fdb927",
                        alternateColor: "1d428a",
                        isActive: true,
                        logo: "https://a.espncdn.com/i/teamlogos/nba/500/gs.png"
                    ),
                statistics: .defaultValue,
                displayOrder: 0,
                homeAway: "home")
            ]
        )
    )
}
