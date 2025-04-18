//
//  VenueModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class VenueModel: Model {
    private(set) var id: String
    private(set) var fullName: String
    private(set) var address: AddressModel
    private(set) var image: String
    
    init(id: String, fullName: String, address: AddressModel, image: String) {
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
    
    static var defaultValue: VenueModel {
        .init(
            id: "",
            fullName: "",
            address: .defaultValue,
            image: ""
        )
    }
    
    static var shimmerValue: VenueModel {
        .init(
            id: "0000",
            fullName: "Lorem Ipsum Arena",
            address: .shimmerValue,
            image: "Lorem"
        )
    }
    
    static var shimmerValues: CountedListModel<VenueModel> {
        let venueModels: [VenueModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: venueModels.count,
            items: venueModels
        )
    }
}

extension VenueModel: ParseableModel {
    static func toObject(fromData data: Any?) -> VenueModel {
        if let data: VenueEntity = data as? VenueEntity {
            return .init(
                id: data.id,
                fullName: data.fullName,
                address: AddressModel.toObject(fromData: data.address),
                image: data.image
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<VenueModel> {
        if let data: CountedListEntity<VenueEntity> = data as? CountedListEntity<VenueEntity> {
            let models: [VenueModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
