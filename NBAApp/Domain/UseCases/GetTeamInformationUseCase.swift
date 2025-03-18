//
//  GetTeamInformationUseCase.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 17/03/25.
//

import Foundation

struct GetTeamInformationUseCase: UseCase {
    private let getTeamInformationRemoteRepository: GetTeamInformationRemoteRepository

    init(getTeamInformationRemoteRepository: GetTeamInformationRemoteRepository) {
        self.getTeamInformationRemoteRepository = getTeamInformationRemoteRepository
    }

    struct Params: UseCaseParams {
        let teamId: String
    }

    struct Response: UseCaseResponse {
        let team: TeamEntity
    }

    func execute(params: Params) async throws -> Response {
        
        let team: TeamEntity = try await self.getTeamInformationRemoteRepository.getTeamInformation(teamId: params.teamId)
        return .init(
            team: team
        )
    }
}
