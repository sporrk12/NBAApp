//
//  GetTeamsUseCase.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import Foundation

struct GetTeamsUseCase: UseCase {
    private let getTeamsRemoteRepository: GetTeamsRemoteRepository

    init(getTeamsRemoteRepository: GetTeamsRemoteRepository) {
        self.getTeamsRemoteRepository = getTeamsRemoteRepository
    }

    struct Params: UseCaseParams { }

    struct Response: UseCaseResponse {
        let sport: SportEntity
    }

    func execute(params: Params) async throws -> Response {
        
        let sport: SportEntity = try await self.getTeamsRemoteRepository.getTeams()
        return .init(
            sport: sport
        )
    }
}

