//
//  GetTeamInformationEndpoint.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 17/03/25.
//

import Foundation

struct GetTeamInformationEndpoint: Endpoint {
    let teamId: String

    var path: String { "/teams" }
    var method: EndpointMethod { .get }

    var queryParams: [String: String]? {[
        "teamId": "\(self.teamId)"
    ]}
}


