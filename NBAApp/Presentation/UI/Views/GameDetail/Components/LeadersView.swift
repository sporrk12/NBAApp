//
//  LeadersView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 18/03/25.
//

import SwiftUI

struct LeadersView: View {
    let leaders: CountedListModel<LeadersModel>
    @State private var selectedLeaderCategory: String = "Points"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Season leaders")
                .font(.title2)
                .bold()
            Picker("Select Leader Category", selection: $selectedLeaderCategory) {
                ForEach(leaders.items.first?.leaders.items ?? [], id: \.displayName) { leader in
                    Text(leader.displayName).tag(leader.displayName)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical)
            ForEach(leaders.items, id: \.team.id) { leader in
                VStack(alignment: .leading) {
                    
                    if let selectedLeader = leader.leaders.items.first(where: { $0.displayName == selectedLeaderCategory }) {
                        LeaderInfoView(leadersInfo: selectedLeader.leaderInfo)
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
    LeadersView(leaders: .init(
        count: 2,
        items: [
            LeadersModel(
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
                leaders: .defaultValue),
            LeadersModel(
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
                leaders: .defaultValue
            )
        ]
    ))
}

