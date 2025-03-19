//
//  VenueDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

class VenueDTO: DTO {
    private(set) var id: String
    private(set) var fullName: String
    private(set) var address: AddressDTO
    private(set) var image: String
    
    init(id: String, fullName: String, address: AddressDTO, image: String) {
        self.id = id
        self.fullName = fullName
        self.address = address
        self.image = image
    }
    
    func toEntity() -> VenueEntity {
        return .init(
            id: self.id,
            fullName: self.fullName,
            address: self.address.toEntity(),
            image: self.image
        )
    }
    
    static var defaultValue: VenueDTO {
        .init(
            id: "",
            fullName: "",
            address: .defaultValue,
            image: ""
        )
    }
}

extension VenueDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> VenueDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let images = data.getArray(key: "images")
            
            
            return .init(
                id: data.getString(key: "id"),
                fullName: data.getString(key: "fullName"),
                address: .toObject(fromData: data.getDictionary(key: "address")) ?? .defaultValue,
                image: images.first?.getString(key: "href") ?? .defaultValue
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<VenueDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [VenueDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [VenueDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: VenueDTO = .toObject(fromData: data) {
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

