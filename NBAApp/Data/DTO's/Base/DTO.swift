//
//  DTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

protocol DTO {
    associatedtype D: DTO = Self

    static var defaultValue: D { get }
}
