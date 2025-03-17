//
//  StatisticsDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

class StatisticsDTO: DTO {
    private(set) var name: String
    private(set) var displayName: String
    private(set) var abbreviation: String
    private(set) var displayValue: String
    private(set) var label: String
    

    init(name: String, displayName: String, abbreviation: String, displayValue: String, label: String) {
        self.name = name
        self.displayName = displayName
        self.abbreviation = abbreviation
        self.displayValue = displayValue
        self.label = label
    }
    
    func toEntity() -> StatisticsEntity {
        return .init(
            name: self.name,
            displayName: self.displayName,
            abbreviation: self.abbreviation,
            displayValue: self.displayValue,
            label: self.label
        )
    }
    
    static var defaultValue: StatisticsDTO {
        .init(
            name: "",
            displayName: "",
            abbreviation: "",
            displayValue: "",
            label: ""
        )
    }
}

extension StatisticsDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> StatisticsDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                name: data.getString(key: "name"),
                displayName: data.getString(key: "displayName"),
                abbreviation: data.getString(key: "abbreviation"),
                displayValue: data.getString(key: "displayValue"),
                label: data.getString(key: "label")
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<StatisticsDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [StatisticsDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [StatisticsDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: StatisticsDTO = .toObject(fromData: data) {
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
