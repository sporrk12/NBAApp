//
//  Entity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

protocol Entity: Sendable {
    associatedtype E: Entity = Self

    static var defaultValue: E { get }
}
