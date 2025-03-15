//
//  Endpoint.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: EndpointMethod { get }
    var queryParams: [String: String]? { get }
    var body: [String: String]? { get }
    var headers: [String: String]? { get }
}

extension Endpoint {
    var queryParams: [String: String]? { nil }
    var body: [String: String]? { nil }
    var headers: [String: String]? { nil }
}

enum EndpointMethod {
    case delete
    case get
    case post
    case put
}
