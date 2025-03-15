//
//  GetGameDetailRemoteRepository.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

protocol GetGameDetailRemoteRepository: RemoteRepository {
    func getGamesDetail(gameId: String) async throws -> CountedListEntity<BoxScoreEntity>
}
