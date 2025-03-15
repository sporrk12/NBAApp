//
//  LineScoreDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

class LineScoreDTO: DTO {
    private(set) var value: Double
    
    init(value: Double) {
        self.value = value
    }
    
    func toEntity() -> LineScoreEntity {
        return .init(
            value: self.value
        )
    }
    
    static var defaultValue: LineScoreDTO {
        .init(value: 0.0)
    }
    
}

extension LineScoreDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> LineScoreDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                value: data.getDouble(key: "value")
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<LineScoreDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [LineScoreDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [LineScoreDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: LineScoreDTO = .toObject(fromData: data) {
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
