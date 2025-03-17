//
//  InjuryDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class InjuryDTO: DTO {
    private(set) var status: String
    private(set) var date: String
    private(set) var athlete: AthleteDTO
    private(set) var type: TypeDTO
    private(set) var details: InjuryDetailDTO
    
    init(status: String, date: String, athlete: AthleteDTO, type: TypeDTO, details: InjuryDetailDTO) {
        self.status = status
        self.date = date
        self.athlete = athlete
        self.type = type
        self.details = details
    }
    
    func toEntity() -> InjuryEntity {
        return .init(
            status: self.status,
            date: self.date,
            athlete: self.athlete.toEntity(),
            type: self.type.toEntity(),
            details: self.details.toEntity()
        )
    }
    
    static var defaultValue: InjuryDTO {
        return .init(
            status: "",
            date: "",
            athlete: .defaultValue,
            type: .defaultValue,
            details: .defaultValue
        )
    }
}

extension InjuryDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> InjuryDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                status: data.getString(key: "status"),
                date: data.getString(key: "date"),
                athlete: .toObject(fromData: data.getDictionary(key: "athlete")) ?? .defaultValue,
                type: .toObject(fromData: data.getDictionary(key: "type")) ?? .defaultValue,
                details: .toObject(fromData: data.getDictionary(key: "details")) ?? .defaultValue
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<InjuryDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [InjuryDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [InjuryDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: InjuryDTO = .toObject(fromData: data) {
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
