//
//  ViewModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    func handleError(_ error: Any) {
        guard let error: Error = error as? Error else {
//            BarAlertManager.instance.showAlert(type: .error, title: "Error", message: "\(error)")
            return
        }

        guard let error: RepositoryError = error as? RepositoryError else {
//            BarAlertManager.instance.showAlert(type: .error, title: "Error", message: error.localizedDescription.replacingOccurrences(of: "\\/", with: "/"))
            return
        }

        switch error {
        case .invalidHTTPURLResponse(json: let json):
            Logger.log("Ocurrió un error tipo \"invalidHTTPURLResponse\" con el siguiente JSON:\n\(json.replacingOccurrences(of: "\\/", with: "/"))")
        case .invalidHTTPURLResponseStatusCode(json: let json):
                Logger.log("Ocurrió un error tipo \"invalidHTTPURLResponseStatusCode\" con el siguiente JSON:\n\(json.replacingOccurrences(of: "\\/", with: "/"))")
        case .invalidURL:
            Logger.log("Ocurrió un error tipo \"invalidURL\"")
        case .noInternetConnection:
            Logger.log("Ocurrió un error tipo \"noInternetConnection\"")
        case .unparsedData:
            Logger.log("Ocurrió un error tipo \"unparsedData\"")
        case .unrecognizedData:
            Logger.log("Ocurrió un error tipo \"unrecognizedData\"")
        }
    }
}
