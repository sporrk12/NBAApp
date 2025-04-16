//
//  TeamsView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct TeamsView: View {
    @StateObject private var viewModel = TeamsViewModel(
        getTeamsUseCase: DependencyInjector.instance.getDependency()!
    )
    
    
    var body: some View {
        NavigationStack {
            Group {
                if self.viewModel.teamsAsyncData.isInProgress {
                    LoadingView()
                }else {
                    
                    ScrollView(showsIndicators: false) {
                        VStack{
                            
                            let teams = self.viewModel.teamsAsyncData.data?.leagues.items.first?.teams.items
                            
                            ForEach(teams ?? [] , id: \.id) { team in
                                NavigationLink(destination: TeamDetailView(teamId: team.id))
                                {
                                    TeamCardView(team: team)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Teams")
        }
    }
}

#Preview {
    TeamsView()
}
