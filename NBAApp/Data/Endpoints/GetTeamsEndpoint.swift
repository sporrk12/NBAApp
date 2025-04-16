//
//  GetTeamsEndpoint.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import Foundation

struct GetTeamsEndpoint: Endpoint {
    
    var path: String { "/teams" }
    var method: EndpointMethod { .get }

}
