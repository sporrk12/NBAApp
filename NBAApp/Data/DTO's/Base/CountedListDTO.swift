//
//  CountedListDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

class CountedListDTO<T>: DTO {
    private(set) var count: Int
    private(set) var items: [T]

    init(count: Int, items: [T]) {
        self.count = count
        self.items = items
    }

    static var defaultValue: CountedListDTO<T> { .init(
        count: 0,
        items: []
    ) }
}
