//
//  CountedListEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

struct CountedListEntity<T: Sendable>: Entity {
    let count: Int
    let items: [T]

    static var defaultValue: CountedListEntity<T> { .init(
        count: 0,
        items: []
    ) }
}

typealias StringCountedListEntity = CountedListEntity<String>
