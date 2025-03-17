//
//  InjuryDetailDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class InjuryDetailDTO: DTO {
    private(set) var type: String
    private(set) var location: String
    private(set) var detail: String
    private(set) var side: String
    private(set) var returnDate: String
    
    init(type: String, location: String, detail: String, side: String, returnDate: String) {
        self.type = type
        self.location = location
        self.detail = detail
        self.side = side
        self.returnDate = returnDate
    }
    
    func toEntity() -> InjuryDetailEntity {
        return .init(
            type: self.type,
            location: self.location,
            detail: self.detail,
            side: self.side,
            returnDate: self.returnDate
        )
    }
    
    static var defaultValue: InjuryDetailDTO {
        .init(
            type: "",
            location: "",
            detail: "",
            side: "",
            returnDate: ""
        )
    }
}

extension InjuryDetailDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> InjuryDetailDTO? {
        if let data: [String: Any] = data as? [String: Any] {

            return .init(
                type: data.getString(key: "type"),
                location: data.getString(key: "location"),
                detail: data.getString(key: "detail"),
                side: data.getString(key: "side"),
                returnDate: data.getString(key: "returnDate")
            
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<InjuryDetailDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [InjuryDetailDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [InjuryDetailDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: InjuryDetailDTO = .toObject(fromData: data) {
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

