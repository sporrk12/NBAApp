//
//  PredictorModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

class PredictorModel: Model {
    private(set) var header: String
    private(set) var homeProjection: String
    private(set) var awayProjection: String

    init(header: String, homeProjection: String, awayProjection: String) {
        self.header = header
        self.homeProjection = homeProjection
        self.awayProjection = awayProjection
    }

    func toEntity() -> PredictorEntity {
        return .init(
            header: self.header,
            homeProjection: self.homeProjection,
            awayProjection: self.awayProjection
        )
    }

    static var defaultValue: PredictorModel {
        .init(
            header: "",
            homeProjection: "",
            awayProjection: ""
        )
    }

    static var shimmerValue: PredictorModel {
        .init(
            header: "Game Prediction",
            homeProjection: "65%",
            awayProjection: "35%"
        )
    }

    static var shimmerValues: CountedListModel<PredictorModel> {
        let predictors: [PredictorModel] = (1...5).map { _ in .shimmerValue }
        return .init(
            count: predictors.count,
            items: predictors
        )
    }
}

extension PredictorModel: ParseableModel {
    static func toObject(fromData data: Any?) -> PredictorModel {
        if let data: PredictorEntity = data as? PredictorEntity {
            return .init(
                header: data.header,
                homeProjection: data.homeProjection,
                awayProjection: data.awayProjection
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<PredictorModel> {
        if let data: CountedListEntity<PredictorEntity> = data as? CountedListEntity<PredictorEntity> {
            let models: [PredictorModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}

