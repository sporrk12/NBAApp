//
//  LastFiveGamesView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 18/03/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct LastFiveGamesView: View {
    let lastFiveGames: CountedListModel<LastFiveGameModel>
    @State private var selectedTeamId: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Last 5 Games")
                .font(.title2)
                .bold()
            
            Picker("Selecciona un equipo", selection: $selectedTeamId) {
                ForEach(lastFiveGames.items, id: \.team.id) { team in
                    Text(team.team.displayName)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical)
            
            Divider()
            
            
            HStack {
                Text("Date").frame(maxWidth: .infinity, alignment: .leading).bold()
                Text("OP").frame(maxWidth: .infinity, alignment: .leading).bold()
                
                Text("Result").frame(maxWidth: .infinity, alignment: .leading).bold()
                
            }
            .foregroundColor(.gray)
            
            
            
            if let selectedTeam = lastFiveGames.items.first(where: { $0.team.id == selectedTeamId }) {
                ScrollView {
                    
                    LazyVStack {
                        ForEach(selectedTeam.events.items, id: \.id) { event in
                            HStack {
                                Text(event.gameDate.convertUTCtoDate() ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack() {
                                    Text(event.atVs)
                                        .foregroundColor(.gray)
                                    
                                    
                                    WebImage(url: URL(string: event.opponent.logo))
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    
                                    
                                    Text(event.opponent.abbreviation)
                                        .foregroundColor(.blue)
                                        .bold()
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                
                                HStack() {
                                    Text(event.gameResult == "W" ? "G" : "P")
                                        .foregroundColor(event.gameResult == "W" ? .green : .red)
                                        .bold()
                                    Text(event.score)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.vertical, 5)
                            .background(Color.black.opacity(0.1))
                        }
                    }
                }
            } else {
                Text("Selecciona un equipo para ver sus juegos")
                    .foregroundColor(.gray)
                    .padding(.top, 10)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .onAppear {
             if let firstTeam = lastFiveGames.items.first {
                 selectedTeamId = firstTeam.team.id
             }
         }
        
    }
    
}

#Preview {
    LastFiveGamesView(lastFiveGames: .defaultValue)
}
