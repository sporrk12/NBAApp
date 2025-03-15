//
//  RecordDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

class RecordDTO: DTO {
    private(set) var name: String
    private(set) var abbreviation: String
    private(set) var type: String
    private(set) var summary: String
    
    init(name: String, abbreviation: String, type: String, summary: String) {
        self.name = name
        self.abbreviation = abbreviation
        self.type = type
        self.summary = summary
    }
    
    func toEntity() -> RecordEntity {
        return .init(
            name: self.name,
            abbreviation: self.abbreviation,
            type: self.type,
            summary: self.summary
        )
    }
    
    static var defaultValue: RecordDTO {
        .init(
            name: "",
            abbreviation: "",
            type: "",
            summary: ""
        )
    }
}

extension RecordDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> RecordDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                name: data.getString(key: "name"),
                abbreviation: data.getString(key: "abbreviation"),
                type: data.getString(key: "type"),
                summary: data.getString(key: "summary")
            )
        }
        return nil
    }
    
    
    static func toList(fromData data: Any?) -> CountedListDTO<RecordDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [RecordDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [RecordDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: RecordDTO = .toObject(fromData: data) {
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
