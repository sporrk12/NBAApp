//
//  GetGameDetailUseCase.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

struct GetGameDetailUseCase: UseCase {
    private let getGameDetailRemoteRepository: GetGameDetailRemoteRepository
    
    init(getGameDetailRemoteRepository: GetGameDetailRemoteRepository) {
        self.getGameDetailRemoteRepository = getGameDetailRemoteRepository
    }
    
    struct Params: UseCaseParams {
        let gameId: String
    }
    
    struct Response: UseCaseResponse {
        let gameDetailCatalog: GameDetailCatalogEntity
    }
    
    func execute(params: Params) async throws -> Response {
        
        let gameDetailCatalog: GameDetailCatalogEntity = try await self.getGameDetailRemoteRepository.getGamesDetail(gameId: params.gameId)
        return .init(
            gameDetailCatalog: gameDetailCatalog
        )
    }
}
