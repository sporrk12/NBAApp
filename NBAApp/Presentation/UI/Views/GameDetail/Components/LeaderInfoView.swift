//
//  LeaderInfoView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 19/03/25.
//

import SwiftUI

struct LeaderInfoView: View {
    let leadersInfo: CountedListModel<LeaderInfoModel>
    var body: some View {
        ForEach(leadersInfo.items, id: \.athlete.id) {
            leaderInfo in
            HStack{
                PlayerLeaderView(athele: leaderInfo.athlete)
                Spacer()
                Text(leaderInfo.displayValue)
                    .padding(.trailing, 25)
                    .font(Font(Fonts.h3.semibold600))
            }
        }
    }
}

#Preview {
    LeaderInfoView(leadersInfo: .defaultValue)
}
