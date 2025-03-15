//
//  DataSource.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

protocol DataSource: Sendable {
    func execute<E: Endpoint>(endpoint: E) async throws -> Any?
}
