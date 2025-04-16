//
//  TeamCardView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct TeamCardView: View {
    let team: TeamModel
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: team.logos.items[5].href)!)
                .resizable()
                .frame(width: 130, height: 130)
                .padding(.horizontal, 20)
            VStack(alignment: .leading) {
                Text(team.location)
                Text(team.name)
            }
            .font(.system(size: 26, weight: .bold))
            
            
            
            Spacer()
            
        }
        .frame(height: 130)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 17))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white.opacity(0.1), lineWidth: 1))
        .padding(.horizontal)
    }
}

#Preview {
    TeamCardView(team: TeamModel(
        id: "27",
        location: "Washington",
        name: "Wizards",
        abbreviation: "WSH",
        displayName: "Washington Wizards",
        shortDisplayName: "Wizards",
        color: "e31837",
        alternateColor: "002b5c",
        isActive: true,
        logo: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/wsh.png",
        logos: .init(count: 6, items: [
            LogoModel(
                href: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/wsh.png",
                width: 0,
                height: 0,
                rel: .defaultValue,
                lastUpdated: ""
            ),
            LogoModel(
                href: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/wsh.png",
                width: 0,
                height: 0,
                rel: .defaultValue,
                lastUpdated: ""
            ),
            LogoModel(
                href: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/wsh.png",
                width: 0,
                height: 0,
                rel: .defaultValue,
                lastUpdated: ""
            ),
            LogoModel(
                href: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/wsh.png",
                width: 0,
                height: 0,
                rel: .defaultValue,
                lastUpdated: ""
            ),
            LogoModel(
                href: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/wsh.png",
                width: 0,
                height: 0,
                rel: .defaultValue,
                lastUpdated: ""
            ),
            LogoModel(
                href: "https://a.espncdn.com/i/teamlogos/nba/500/scoreboard/wsh.png",
                width: 0,
                height: 0,
                rel: .defaultValue,
                lastUpdated: ""
            )
        ]),
        records: .defaultValue,
        venue: .defaultValue,
        standingSummary: "",
        nextEvent: .defaultValue
    ))
}
