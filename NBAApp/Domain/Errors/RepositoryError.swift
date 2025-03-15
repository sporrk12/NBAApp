//
//  RepositoryError.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

enum RepositoryError: LocalizedError {
    case invalidHTTPURLResponse(json: String)
    case invalidHTTPURLResponseStatusCode(json: String)
    case invalidURL
    case noInternetConnection
    case unparsedData
    case unrecognizedData

    var errorDescription: String? {
        switch self {
        case .invalidHTTPURLResponse(let json):
            return "\(json)"
        case .invalidHTTPURLResponseStatusCode(let json):
            return "\(json)"
        case .invalidURL:
            return ""
        case .noInternetConnection:
            return ""
        case .unparsedData:
            return ""
        case .unrecognizedData:
            return ""
        }
    }

    var failureReason: String? {
        switch self {
        case .invalidHTTPURLResponse(let json):
            return "\(json)"
        case .invalidHTTPURLResponseStatusCode(let json):
            return "\(json)"
        case .invalidURL:
            return ""
        case .noInternetConnection:
            return ""
        case .unparsedData:
            return ""
        case .unrecognizedData:
            return ""
        }
    }
}

