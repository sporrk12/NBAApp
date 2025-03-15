//
//  TypeModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

enum StatusTypeCategory: String {
    case pre = "1"
    case inProgress = "2"
    case final = "3"
    case finalQuarter = "22"
    case unknown
    
    init(id: String) {
        self = StatusTypeCategory(rawValue: id) ?? .unknown
    }
}

class TypeModel: Model {
    private(set) var id: String
    private(set) var name: String
    private(set) var state: String
    private(set) var completed: Bool
    private(set) var description: String
    private(set) var detail: String
    private(set) var shortDetail: String
    
    var typeCategory: StatusTypeCategory {
        return StatusTypeCategory(id: self.id)
    }
    
    init(id: String, name: String, state: String, completed: Bool, description: String, detail: String, shortDetail: String) {
        self.id = id
        self.name = name
        self.state = state
        self.completed = completed
        self.description = description
        self.detail = detail
        self.shortDetail = shortDetail
    }
    
    func toEntity() -> TypeEntity {
        return .init(
            id: self.id,
            name: self.name,
            state: self.state,
            completed: self.completed,
            description: self.description,
            detail: self.detail,
            shortDetail: self.shortDetail
        )
    }
    
    static var defaultValue: TypeModel {
        .init(
            id: "",
            name: "",
            state: "",
            completed: false,
            description: "",
            detail: "",
            shortDetail: ""
        )
    }
    
    static var shimmerValue: TypeModel {
        .init(
            id: "0000",
            name: "Lorem Ipsum",
            state: "Active",
            completed: false,
            description: "Description placeholder",
            detail: "Detail placeholder",
            shortDetail: "Short detail"
        )
    }
    
    static var shimmerValues: CountedListModel<TypeModel> {
        let typeModels: [TypeModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: typeModels.count,
            items: typeModels
        )
    }
}

extension TypeModel: ParseableModel {
    static func toObject(fromData data: Any?) -> TypeModel {
        if let data: TypeEntity = data as? TypeEntity {
            return .init(
                id: data.id,
                name: data.name,
                state: data.state,
                completed: data.completed,
                description: data.description,
                detail: data.detail,
                shortDetail: data.shortDetail
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<TypeModel> {
        if let data: CountedListEntity<TypeEntity> = data as? CountedListEntity<TypeEntity> {
            let models: [TypeModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
