//
//  PlayerLeaderView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 19/03/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct PlayerLeaderView: View {
    let athele: AthleteModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                
                WebImage(url: URL(string: athele.headshot))
                    .resizable()
                    .frame(width: 80, height: 56)
                    .clipShape(Circle())
                    .background(Circle().fill(Color.black))
                
                VStack(alignment: .leading){
                    
                    Text(athele.displayName)
                    
                    Text("#\(athele.jersey)  |  \(athele.position)")
                    
                }
            }
        }
    }
}

#Preview {
    PlayerLeaderView(athele: .defaultValue)
}
