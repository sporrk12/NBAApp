//
//  StringExtension.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 13/03/25.
//

import Foundation


extension String {
    /// Convierte una fecha en UTC a UTC-6 (CST) y devuelve solo la hora en formato de 12 horas con AM/PM
    func convertUTCtoCSTTime() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "h:mm a"
        outputFormatter.timeZone = TimeZone(secondsFromGMT: -21600)

        if let date = inputFormatter.date(from: self) {
            return outputFormatter.string(from: date)
        }
        return nil
    }
}

