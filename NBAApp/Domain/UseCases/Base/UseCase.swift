//
//  UseCase.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

protocol UseCase: Sendable {
    associatedtype Params: UseCaseParams
    associatedtype Response: UseCaseResponse

    func execute(params: Params) async throws -> Response
}

protocol UseCaseParams {}

protocol UseCaseResponse: Sendable {}
