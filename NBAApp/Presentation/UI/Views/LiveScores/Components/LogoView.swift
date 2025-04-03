//
//  LogoView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 31/03/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct LogoView: View {
    let imageURL: String
    let alignment: Alignment
    
    var body: some View {
        if imageURL.contains("utah") {
            Image("utah")
                .resizable()
                .scaledToFill()
                .frame(width: 200)
                .offset(x: alignment == .leading ? -35 : 35)
                .clipped()
                .frame(width: 100)
        } else {
            WebImage(url: URL(string: imageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 200)
                .offset(x: alignment == .leading ? -35 : 35)
                .clipped()
                .frame(width: 100)
        }
    }
}

#Preview {
    LogoView(imageURL: "https://a.espncdn.com/i/teamlogos/nba/500/utah.png", alignment: .leading)
        .frame(height: 130)
}
