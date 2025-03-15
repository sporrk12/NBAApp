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
    
    func getGamesDetail(gameId: String) async throws -> CountedListEntity<BoxScoreEntity> {
        let endpoint: Endpoint = GetGameDetailEndpoint(gameId: gameId)
        let data: Any? = try await self.dataSource.execute(endpoint: endpoint)
       
        guard let json: [String: Any] = data as? [String: Any] else {
            throw RepositoryError.unrecognizedData
        }
        
        guard let eventsDTO: CountedListDTO<BoxScoreDTO> = BoxScoreDTO.toList(fromData: json.getArray(key: "boxscore")) else {
            throw RepositoryError.unparsedData
        }
        
        let eventsEntity: CountedListEntity<BoxScoreEntity> = .init(
            count: eventsDTO.count,
            items: eventsDTO.items.map { $0.toEntity() }
        )
        
        return eventsEntity
    }
}
