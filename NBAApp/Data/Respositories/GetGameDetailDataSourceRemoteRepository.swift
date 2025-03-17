//
//  GetGameDetailDataSourceRemoteRepository.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

struct GetGameDetailDataSourceRemoteRepository: GetGameDetailRemoteRepository {
    
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func getGamesDetail(gameId: String) async throws -> GameDetailCatalogEntity {
        let endpoint: Endpoint = GetGameDetailEndpoint(gameId: gameId)
        let data: Any? = try await self.dataSource.execute(endpoint: endpoint)
        
        guard let json: [String: Any] = data as? [String: Any] else {
            throw RepositoryError.unrecognizedData
        }
        
        guard let gameDetailCatalogDTO: GameDetailCatalogDTO = .toObject(fromData: json) else {
            throw RepositoryError.unparsedData
        }
        
        let gameDetailCatalogEntity: GameDetailCatalogEntity = gameDetailCatalogDTO.toEntity()
        
        return gameDetailCatalogEntity
    }
}
