//
//  GetTeamInformationDataSourceRemoteRepository.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 17/03/25.
//

import Foundation


struct GetTeamInformationDataSourceRemoteRepository: GetTeamInformationRemoteRepository {

    private let dataSource: DataSource

    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func getTeamInformation(teamId: String) async throws -> TeamEntity {
        let endpoint: Endpoint = GetTeamInformationEndpoint(teamId: teamId)
        let data: Any? = try await self.dataSource.execute(endpoint: endpoint)
       
        guard let json: [String: Any] = data as? [String: Any] else {
            throw RepositoryError.unrecognizedData
        }
        
        guard let teamDTO: TeamDTO = TeamDTO.toObject(fromData: json) else {
            throw RepositoryError.unparsedData
        }
        
        let teamEntity: TeamEntity = teamDTO.toEntity()
        
        return teamEntity
    }
    
}

