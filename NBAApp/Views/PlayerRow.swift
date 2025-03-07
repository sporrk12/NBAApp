//
//  PlayerRow.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 28/01/25.
//

import SwiftUI

struct PlayerRow: View {
    let player: PlayerModel

    var body: some View {
        HStack {
            // Imagen del jugador
            AsyncImage(url: URL(string: player.imageURL!)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            } placeholder: {
                ProgressView()
                    .frame(width: 60, height: 60)
            }
            

            // Información del jugador
            VStack(alignment: .leading) {
                Text(player.name)
                    .font(.headline)
                VStack (alignment: .leading){
                    Text("Puntos: \(player.points ?? 0)")
                    Text("Rebotes: \(player.rebounds ?? 0)")
                    Text("Asistencias: \(player.assists ?? 0)")
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
}

//#Preview {
//    PlayerRow()
//}
