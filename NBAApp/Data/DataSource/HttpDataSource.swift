//
//  HttpDataSource.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct HttpDataSource: DataSource {
    private let host: String
    
    init(host: String) {
        self.host = host
    }
    
    func execute<E: Endpoint>(endpoint: E) async throws -> Any? {
        let url: URL = try self.getURL(path: endpoint.path, queryParams: endpoint.queryParams)
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "\(endpoint.method)".uppercased()
        
        
        self.printEndpoint(
            endpointName: String(describing: type(of: endpoint)),
            url: url,
            method: "\(endpoint.method)".uppercased()
        )
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            var json: [String: Any] = data.toJsonObject() ?? [:]
            
            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
                json["api_url"] = "\(endpoint.method): \(endpoint.path)"
                throw RepositoryError.invalidHTTPURLResponse(json: json.toString())
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                json["api_url"] = "\(endpoint.method): \(endpoint.path)"
                throw RepositoryError.invalidHTTPURLResponseStatusCode(json: json.toString())
            }
            
            return json
        } catch {
            if let urlError: URLError = error as? URLError {
                if urlError.errorCode == -1009 {
                    throw RepositoryError.noInternetConnection
                }
            }
            
            throw error
        }
    }
    
    private func getURL(path: String, queryParams: [String: String]?) throws -> URL {
        guard let url: URL = URL(string: self.host + path) else {
            throw RepositoryError.invalidURL
        }
        
        guard var urlComponents: URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw RepositoryError.invalidURL
        }
        
        if let queryParams: [String: String] = queryParams {
            urlComponents.queryItems = queryParams.map({
                URLQueryItem(name: $0.key, value: $0.value)
            })
        }
        
        guard let url: URL = urlComponents.url else {
            throw RepositoryError.invalidURL
        }
        
        return url
    }
    
    private func printEndpoint(endpointName: String, url: URL, method: String) {
        let methodWithUrl: String = "\(method.uppercased()): \(url)"
        
        var info: String = ""
        info = "\(info)\(methodWithUrl)"
        
        if Constants.printAllEndpointInformation {
            
            info = "\(info)\n"
            info = "\(info)endpoint: \(endpointName)"
            info = "\(info)\n"
        }
        
        Logger.log(info)
    }
}

