//
//  GetGamesByDateDataSourceRemoteRepository.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 13/03/25.
//

import Foundation

struct GetGamesByDateDataSourceRemoteRepository: GetGamesByDateRemoteRepository {

    private let dataSource: DataSource

    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func getGamesByDate(date: String) async throws -> CountedListEntity<EventEntity> {
        let endpoint: Endpoint = GetGamesByDateEndpoint(date: date)
        let data: Any? = try await self.dataSource.execute(endpoint: endpoint)
       
        guard let json: [String: Any] = data as? [String: Any] else {
            throw RepositoryError.unrecognizedData
        }
        
        guard let eventsDTO: CountedListDTO<EventDTO> = EventDTO.toList(fromData: json.getArray(key: "events")) else {
            throw RepositoryError.unparsedData
        }
        
        let eventsEntity: CountedListEntity<EventEntity> = .init(
            count: eventsDTO.count,
            items: eventsDTO.items.map { $0.toEntity() }
        )
        
        return eventsEntity
    }
}
