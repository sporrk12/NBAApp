//
//  GetGamesByDateUseCase.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 13/03/25.
//

import Foundation

struct GetGamesByDateUseCase: UseCase {
    private let getGamesByDateRemoteRepository: GetGamesByDateRemoteRepository

    init(getGamesByDateRemoteRepository: GetGamesByDateRemoteRepository) {
        self.getGamesByDateRemoteRepository = getGamesByDateRemoteRepository
    }

    struct Params: UseCaseParams {
        let date: String
    }

    struct Response: UseCaseResponse {
        let events: CountedListEntity<EventEntity>
    }

    func execute(params: Params) async throws -> Response {
        
        let events: CountedListEntity<EventEntity> = try await self.getGamesByDateRemoteRepository.getGamesByDate(date: params.date)
        return .init(
            events: events
        )
    }
}

