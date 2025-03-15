//
//  GameDetailView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import SwiftUI

//struct GameDetailView: View {
//    let game: EventModel
//    
//    var body: some View {
//        VStack {
//            Text("\(game.competitions.items[0].competitors.items[0].team.name) vs \(game.competitions.items[0].competitors.items[1].team.name)")
//                .font(.title)
//                .bold()
//            
//            // Puntajes por cuarto
//            VStack {
//                Text("Puntajes por Cuarto")
//                    .font(.headline)
//                
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text("\(game.homeTeam.name): \(game.scores.home.quarters.joined(separator: " - "))")
//                        Text("\(game.awayTeam.name): \(game.scores.away.quarters.joined(separator: " - "))")
//                    }
//                }
//                .padding()
//            }
//            
//            // Líderes del partido
//            VStack {
//                Text("Líderes del Partido")
//                    .font(.headline)
//                
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text("🏀 Puntos: \(game.leaders.points.playerName) - \(game.leaders.points.value)")
//                        Text("🔄 Asistencias: \(game.leaders.assists.playerName) - \(game.leaders.assists.value)")
//                        Text("🛑 Rebotes: \(game.leaders.rebounds.playerName) - \(game.leaders.rebounds.value)")
//                    }
//                }
//                .padding()
//            }
//            
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("Detalles del Partido")
//    }
//}
//
//#Preview {
//    GameDetailView()
//}
