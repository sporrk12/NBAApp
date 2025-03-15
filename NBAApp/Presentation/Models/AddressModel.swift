//
//  AddressModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

class AddressModel: Model {
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
    
    static var defaultValue: AddressModel {
        .init(
            city: "",
            state: ""
        )
    }
    
    static var shimmerValue: AddressModel {
        .init(
            city: "Lorem ipsum",
            state: "Lorem ipsum"
        )
    }
    
    static var shimmerValues: CountedListModel<AddressModel> {
        let addressModel: [AddressModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: addressModel.count,
            items: addressModel
        )
    }
}

extension AddressModel: ParseableModel {
    
    static func toObject(fromData data: Any?) -> AddressModel {
        if let data: AddressEntity = data as? AddressEntity {
            
            return .init(
                city: data.city,
                state: data.state
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<AddressModel> {
        if let data: CountedListEntity<AddressEntity> = data as? CountedListEntity<AddressEntity> {
            var models: [AddressModel] = []
            for data in data.items {
                let model: AddressModel = .toObject(fromData: data)
                models.append(model)
            }
            
            return .init(
                count: data.count,
                items: models
            )
        }
        
        return .defaultValue
    }
}

