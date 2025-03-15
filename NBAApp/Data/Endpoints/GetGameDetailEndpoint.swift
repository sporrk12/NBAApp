//
//  GetGameDetailEndpoint.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

struct GetGameDetailEndpoint: Endpoint {
    let gameId: String

    var path: String { "/summary" }
    var method: EndpointMethod { .get }

    var queryParams: [String: String]? {[
        "event": "\(self.gameId)"
    ]}
}
