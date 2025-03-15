//
//  ParseableDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

protocol ParseableDTO {
    associatedtype D: DTO
    
    static func toObject(fromData data: Any?) -> D?
    
    static func toList(fromData data: Any?) -> CountedListDTO<D>?
}

