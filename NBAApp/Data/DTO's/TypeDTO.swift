//
//  TypeDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

class TypeDTO: DTO {
    private(set) var id: String
    private(set) var name: String
    private(set) var state: String
    private(set) var completed: Bool
    private(set) var description: String
    private(set) var detail: String
    private(set) var shortDetail: String
    private(set) var abbreviation: String
    
    init(id: String, name: String, state: String, completed: Bool, description: String, detail: String, shortDetail: String, abbreviation: String) {
        self.id = id
        self.name = name
        self.state = state
        self.completed = completed
        self.description = description
        self.detail = detail
        self.shortDetail = shortDetail
        self.abbreviation = abbreviation
    }
    
    func toEntity() -> TypeEntity {
        return .init(
            id: self.id,
            name: self.name,
            state: self.state,
            completed: self.completed,
            description: self.description,
            detail: self.detail,
            shortDetail: self.shortDetail,
            abbreviation: self.abbreviation
        )
    }
    
    static var defaultValue: TypeDTO {
        .init(
            id: "",
            name: "",
            state: "",
            completed: false,
            description: "",
            detail: "",
            shortDetail: "",
            abbreviation: ""
        )
    }
}

extension TypeDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> TypeDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                id: data.getString(key: "id"),
                name: data.getString(key: "name"),
                state: data.getString(key: "state"),
                completed: data.getBool(key: "completed"),
                description: data.getString(key: "description"),
                detail: data.getString(key: "detail"),
                shortDetail: data.getString(key: "shortDetail"),
                abbreviation: data.getString(key: "abbreviation")
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<TypeDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [TypeDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [TypeDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: TypeDTO = .toObject(fromData: data) {
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


