//
//  ParsebaleModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

protocol ParseableModel {
    associatedtype M: Model = Self

    static func toObject(fromData data: Any?) -> M

    static func toList(fromData data: Any?) -> CountedListModel<M>

}
