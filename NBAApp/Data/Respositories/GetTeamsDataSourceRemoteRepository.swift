//
//  GetTeamsDataSourceRemoteRepository.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import Foundation

struct GetTeamsDataSourceRemoteRepository: GetTeamsRemoteRepository {
    
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func getTeams() async throws -> SportEntity {
        let endpoint: Endpoint = GetTeamsEndpoint()
        let data: Any? = try await self.dataSource.execute(endpoint: endpoint)
        
        guard let json: [String: Any] = data as? [String: Any] else {
            throw RepositoryError.unrecognizedData
        }
        
        guard let sportsDTO: CountedListDTO<SportDTO> = SportDTO.toList(fromData: json.getArray(key: "sports")),
              let sportDTO = sportsDTO.items.first else {
            throw RepositoryError.unparsedData
        }
        
        return sportDTO.toEntity()
    }
}

