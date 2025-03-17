//
//  GameDetailView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import SwiftUI

struct GameDetailView: View {
    let gameId: String
    
    @StateObject private var viewModel = GameDetailViewModel(
        getGameDetailUseCase: DependencyInjector.instance.getDependency()!
    )
    
    var body: some View {
        Text(self.viewModel.gameDetailCatalogAsyncData.data?.predictor.homeProjection ?? "")
            .onAppear {
                self.viewModel.getGameDetail(gameId: gameId)
            }
    }
}

#Preview {
    GameDetailView(gameId: "401705542")
}
