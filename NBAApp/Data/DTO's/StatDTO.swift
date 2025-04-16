//
//  StatDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/04/25.
//

import Foundation

class StatDTO: DTO {
    private(set) var name: String
    private(set) var value: String

    init(name: String, value: String) {
        self.name = name
        self.value = value
    }

    func toEntity() -> StatEntity {
        return .init(
            name: self.name,
            value: self.value
        )
    }

    static var defaultValue: StatDTO {
        .init(name: "", value: "")
    }
}

extension StatDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> StatDTO? {
        if let data = data as? [String: Any] {
            return .init(
                name: data.getString(key: "name"),
                value: data.getString(key: "value")
            )
        }
        return nil
    }

    static func toList(fromData data: Any?) -> CountedListDTO<StatDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [StatDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [StatDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: StatDTO = .toObject(fromData: data) {
                    dtos.append(dto)
                }
            }
            return .init(
                count: data.getInt(key: "count"),
                items: dtos
            )
        }
        return nil
    }
}
