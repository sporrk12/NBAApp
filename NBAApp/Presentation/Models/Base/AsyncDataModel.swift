//
//  AsyncDataModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct AsyncDataModel<T: Model>: Model {
    let data: T?
    let error: Any?
    let status: AsyncDataStatus

    var isInitial: Bool { self.status == .initial }
    var hasData: Bool { self.data != nil }
    var hasError: Bool { self.error != nil }
    var isInProgress: Bool { self.status == .inProgress }

    static func inProgress(data: T? = nil) -> AsyncDataModel<T> {
        return .init(
            data: data,
            error: nil,
            status: .inProgress
        )
    }

    static func success(data: T) -> AsyncDataModel<T> {
        return .init(
            data: data,
            error: nil,
            status: .success
        )
    }

    static func failure(_ error: Any) -> AsyncDataModel<T> {
        return .init(
            data: nil,
            error: error,
            status: .failure
        )
    }

    static var defaultValue: AsyncDataModel<T> { .init(data: nil, error: nil, status: .initial) }

    static var shimmerValue: AsyncDataModel<T> { .defaultValue }

    static var shimmerValues: CountedListModel<AsyncDataModel<T>> { .defaultValue }
}

enum AsyncDataStatus {
    case initial
    case inProgress
    case success
    case failure
}
