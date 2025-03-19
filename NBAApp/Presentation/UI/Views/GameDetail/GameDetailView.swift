//
//  GameDetailView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetailView: View {
    let gameId: String
    let gameStatus: StatusTypeCategory
    
    @StateObject private var viewModel = GameDetailViewModel(
        getGameDetailUseCase: DependencyInjector.instance.getDependency()!
    )
    
    var body: some View {
        ScrollView{
            VStack{
                if self.viewModel.gameDetailCatalogAsyncData.isInProgress {
                    ZStack {
                        Color.black.ignoresSafeArea()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                    }
                }
                else{
                    VStack {
                        switch gameStatus {
                        case .pre:
                            PredictorChartView(
                                predictor: self.viewModel.gameDetailCatalogAsyncData.data?.predictor ?? .defaultValue,
                                teams: self.viewModel.gameDetailCatalogAsyncData.data?.boxscore.teams ?? .defaultValue
                            )
                            .frame(height: 450)
                            
                            LeadersView(leaders: self.viewModel.gameDetailCatalogAsyncData.data?.leaders ?? .defaultValue)
                            
                            LastFiveGamesView(lastFiveGames: self.viewModel.gameDetailCatalogAsyncData.data?.lastFiveGames ?? .defaultValue)
                            
                            VenueInformationView(venue: self.viewModel.gameDetailCatalogAsyncData.data?.venue ?? .defaultValue)
                        case .inProgress:
                            BoxscoreView(boxscore: self.viewModel.gameDetailCatalogAsyncData.data?.boxscore ?? .defaultValue)
                        case .final:
                            EmptyView()
                        case .finalQuarter:
                            Text("Final Quarter")
                        case .unknown:
                            EmptyView()
                        }
                    }
                }
            }
            
        }
        .onAppear {
            self.viewModel.getGameDetail(gameId: gameId)
        }
    }
    
}

#Preview {
    GameDetailView(gameId: "401705565", gameStatus: .pre)
}
