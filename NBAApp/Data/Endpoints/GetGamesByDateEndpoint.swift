//
//  GetGamesByDateEndpoint.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 13/03/25.
//

import Foundation

struct GetGamesByDateEndpoint: Endpoint {
    let date: String

    var path: String { "/scoreboard" }
    var method: EndpointMethod { .get }

    var queryParams: [String: String]? {[
        "dates": "\(self.date)"
    ]}
}
