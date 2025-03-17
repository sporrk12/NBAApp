//
//  GameDetailViewModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import Foundation

@MainActor
class GameDetailViewModel: ViewModel {
    @Published var gameDetailCatalogAsyncData: AsyncDataModel<GameDetailCatalogModel> = .defaultValue
    
    private var getGameDetailUseCase: GetGameDetailUseCase
    
    init(getGameDetailUseCase: GetGameDetailUseCase) {
        self.getGameDetailUseCase = getGameDetailUseCase
        super.init()
    }
    
    func  getGameDetail(gameId: String) {
        Task {
            do {
                self.gameDetailCatalogAsyncData = .inProgress(data: GameDetailCatalogModel.shimmerValue)
                
                let gameDetailCatalogResponse: GetGameDetailUseCase.Response = try await self.getGameDetailUseCase.execute(params: .init(gameId: gameId))
                
                let gameDetailCatalogEntity: GameDetailCatalogModel = .toObject(fromData: gameDetailCatalogResponse.gameDetailCatalog)
                
                self.gameDetailCatalogAsyncData = .success(data: gameDetailCatalogEntity)
                
            } catch {
                self.handleError(error)
                self.gameDetailCatalogAsyncData = .failure(error)
            }
        }
    }
    
}

