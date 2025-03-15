//
//  AddressDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

class AddressDTO: DTO {
    private(set) var city: String
    private(set) var state: String
    
    init(city: String, state: String) {
        self.city = city
        self.state = state
    }
    
    func toEntity() -> AddressEntity {
        return .init(
            city: self.city,
            state: self.state
        )
    }
    
    static var defaultValue: AddressDTO {
        .init(
            city: "",
            state: ""
        )
    }
}

extension AddressDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> AddressDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                city: data.getString(key: "city"),
                state: data.getString(key: "state")
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<AddressDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            let items: [AddressDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [AddressDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: AddressDTO = .toObject(fromData: data) {
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
