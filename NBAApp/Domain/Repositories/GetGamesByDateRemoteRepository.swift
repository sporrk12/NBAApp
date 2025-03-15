//
//  GetGamesByDateRemoteRepository.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 13/03/25.
//

import Foundation

protocol GetGamesByDateRemoteRepository: RemoteRepository {
    func getGamesByDate(date: String) async throws -> CountedListEntity<EventEntity>
}
