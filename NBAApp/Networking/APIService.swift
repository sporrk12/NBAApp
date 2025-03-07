////
////  APIService.swift
////  NBAApp
////
////  Created by Emmanuel  Granados on 24/01/25.
////
//
//import Foundation
//
//class APIService {
//    static let shared = APIService()
//    private let baseURL = "http://127.0.0.1:5000" // Cambia a tu servidor si es necesario
//    
//    private init() {}
//    
//    // Fetch player stats
//    func fetchPlayerStats(playerID: String, completion: @escaping (Result<PlayerResponse, Error>) -> Void) {
//        let url = URL(string: "\(baseURL)/player/\(playerID)")!
//        print("URL: \(url)")
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
//                return
//            }
//            
//            do {
//                let playerResponse = try JSONDecoder().decode(PlayerResponse.self, from: data)
//                completion(.success(playerResponse))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//    
//    // Fetch live games
//    func fetchLiveGames(completion: @escaping (Result<LiveGamesResponse, Error>) -> Void) {
//        let url = URL(string: "\(baseURL)/games/live")!
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
//                return
//            }
//
//            do {
//                let liveGamesResponse = try JSONDecoder().decode(LiveGamesResponse.self, from: data)
//                completion(.success(liveGamesResponse))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//    
//    func fetchLast5Games(playerID: String, completion: @escaping (Result<Last5GamesResponse, Error>) -> Void) {
//        let url = URL(string: "\(baseURL)/player/\(playerID)/last5games")!
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
//                return
//            }
//
//            do {
//                let last5GamesResponse = try JSONDecoder().decode(Last5GamesResponse.self, from: data)
//                completion(.success(last5GamesResponse))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//    
//    func fetchBoxScore(gameID: String, completion: @escaping (Result<BoxScoreResponse, Error>) -> Void) {
//        let url = URL(string: "\(baseURL)/game/\(gameID)/boxscore")!
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
//                return
//            }
//
//            do {
//                let boxScoreResponse = try JSONDecoder().decode(BoxScoreResponse.self, from: data)
//                completion(.success(boxScoreResponse))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//    
//    
//    func fetchTeams(completion: @escaping (Result<[Team], Error>) -> Void) {
//        let url = URL(string: "\(baseURL)/teams")!
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
//                return
//            }
//
//            do {
//                let teams = try JSONDecoder().decode([Team].self, from: data)
//                completion(.success(teams))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//
//    func fetchPlayers(teamID: Int, completion: @escaping (Result<[Player], Error>) -> Void) {
//        let url = URL(string: "\(baseURL)/team/\(teamID)/players")!
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
//                return
//            }
//
//            do {
//                let players = try JSONDecoder().decode([Player].self, from: data)
//                completion(.success(players))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//}
