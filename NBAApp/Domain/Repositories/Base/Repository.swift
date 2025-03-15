//
//  Repository.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

protocol Repository: Sendable {}

protocol LocalRepository: Repository {}

protocol RemoteRepository: Repository {}
