//
//  PlayerStatisticsDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import Foundation

class PlayerStatisticsDTO: DTO {
    private(set) var names : CountedListDTO<String>
    private(set) var keys : CountedListDTO<String>
    private(set) var labels : CountedListDTO<String>
    private(set) var descriptions : CountedListDTO<String>
    private(set) var athletes : CountedListDTO<AthletesDTO>
    private(set) var totals : CountedListDTO<String>
    

    init(names: CountedListDTO<String>, keys: CountedListDTO<String>, labels: CountedListDTO<String>, descriptions: CountedListDTO<String>, athletes: CountedListDTO<AthletesDTO>, totals: CountedListDTO<String>) {
        self.names = names
        self.keys = keys
        self.labels = labels
        self.descriptions = descriptions
        self.athletes = athletes
        self.totals = totals
    }
    
    func toEntity() -> PlayerStatisticsEntity {
        return .init(
            names: .init(
                count: self.names.count,
                items: self.names.items
            ),
            keys: .init(
                count: self.keys.count,
                items: self.keys.items
            ),
            labels: .init(
                count: self.labels.count,
                items: self.labels.items
            ),
            descriptions:.init(
                count: self.descriptions.count,
                items: self.descriptions.items
            ),
            athletes: .init(
                count: self.athletes.count,
                items: self.athletes.items.compactMap{ $0.toEntity() }
            ),
            totals: .init(
                count: self.totals.count,
                items: self.totals.items
            )
        )
    }
    
    static var defaultValue: PlayerStatisticsDTO {
        .init(
            names: .defaultValue,
            keys: .defaultValue,
            labels: .defaultValue,
            descriptions: .defaultValue,
            athletes: .defaultValue,
            totals: .defaultValue
        )
    }
}

extension PlayerStatisticsDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> PlayerStatisticsDTO? {
        if let data = data as? [String: Any] {
            
            let athletes: CountedListDTO<AthletesDTO> = AthletesDTO.toList(fromData: data.getArray(key: "athletes")) ?? .defaultValue
            
            return .init(
                names: String.toList(fromData: data.getArray(key: "names")) ?? .defaultValue,
                keys: String.toList(fromData: data.getArray(key: "keys")) ?? .defaultValue,
                labels: String.toList(fromData: data.getArray(key: "labels")) ?? .defaultValue,
                descriptions: String.toList(fromData: data.getArray(key: "descriptions")) ?? .defaultValue,
                athletes: athletes,
                totals: String.toList(fromData: data.getArray(key: "totals")) ?? .defaultValue
            )
        }
        return nil
    }

    static func toList(fromData data: Any?) -> CountedListDTO<PlayerStatisticsDTO>? {
        if let data = data as? [[String: Any]] {
            let items: [PlayerStatisticsDTO] = data.compactMap { toObject(fromData: $0) }
            return .init(count: items.count, items: items)
        }

        if let data = data as? [String: Any] {
            var dtos: [PlayerStatisticsDTO] = []
            for item in data.getArray(key: "items") {
                if let dto: PlayerStatisticsDTO = .toObject(fromData: item) {
                    dtos.append(dto)
                }
            }
            return .init(count: data.getInt(key: "count"), items: dtos)
        }
        return nil
    }
}

