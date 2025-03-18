//
//  GetTeamInformationRemoteRepository.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 17/03/25.
//

protocol GetTeamInformationRemoteRepository: RemoteRepository {
    func getTeamInformation(teamId: String) async throws -> TeamEntity
}
