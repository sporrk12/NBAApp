//
//  CountedListModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

class CountedListModel<T>: Model {
    private(set) var count: Int
    private(set) var items: [T]

    init(count: Int, items: [T]) {
        self.count = count
        self.items = items
    }

    static var defaultValue: CountedListModel<T> { .init(
        count: 0,
        items: []
    ) }

    static var shimmerValue: CountedListModel { .defaultValue }

    static var shimmerValues: CountedListModel<CountedListModel<T>> { .defaultValue }
}
