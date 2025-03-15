//
//  Model.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

protocol Model {
    associatedtype M: Model = Self

    static var defaultValue: M { get }

    static var shimmerValue: M { get }

    static var shimmerValues: CountedListModel<M> { get }
}
