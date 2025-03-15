//
//  StatusDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

class StatusDTO: DTO {
    private(set) var displayClock: String
    private(set) var period: Int
    private(set) var type: TypeDTO
    
    init(displayClock: String, period: Int, type: TypeDTO) {
        self.displayClock = displayClock
        self.period = period
        self.type = type
    }
    
    func toEntity() -> StatusEntity {
        return .init(
            displayClock: self.displayClock,
            period: self.period,
            type: self.type.toEntity()
        )
    }
    
    static var defaultValue: StatusDTO {
        .init(
            displayClock: "",
            period: 0,
            type: .defaultValue
        )
    }
}

extension StatusDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> StatusDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                displayClock: data.getString(key: "displayClock"),
                period: data.getInt(key: "period"),
                type: .toObject(fromData: data.getDictionary(key: "type")) ?? .defaultValue
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<StatusDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [StatusDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [StatusDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: StatusDTO = .toObject(fromData: data) {
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
