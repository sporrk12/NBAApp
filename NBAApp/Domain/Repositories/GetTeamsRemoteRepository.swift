//
//  GetTeamsRemoteRepository.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

protocol GetTeamsRemoteRepository: RemoteRepository {
    func getTeams() async throws -> SportEntity
}
