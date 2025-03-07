//
//  NBAAPIService.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 27/01/25.
//

import Foundation

class NBAService {
    static let shared = NBAService()
    private let baseURL = "http://127.0.0.1:5000"
    
    // MARK: Endpoint to recieve the live games
    func fetchLiveGames(completion: @escaping (Result<LiveGamesModel, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/games/live") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(LiveGamesModel.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: Endpoint that recieve the boxscore of a games
    func fetchBoxscore(for gameID: String, completion: @escaping (Result<BoxScoreModel, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/games/\(gameID)/boxscore") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(BoxScoreModel.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchGames(for date: String, completion: @escaping (Result<LiveGamesModel, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/games/by-date?date=\(date)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(LiveGamesModel.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchTeams(completion: @escaping (Result<[TeamModel], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/teams") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let teams = try JSONDecoder().decode([TeamModel].self, from: data)
                completion(.success(teams))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPlayers(for teamID: Int, completion: @escaping (Result<[PlayerModel], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/teams/\(teamID)/players") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let players = try JSONDecoder().decode([PlayerModel].self, from: data)
                completion(.success(players))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // Obtener información de un jugador
    func fetchPlayerDetails(playerID: Int, completion: @escaping (Result<PlayerModel, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/player/\(playerID)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
                return
            }

            do {
                let player = try JSONDecoder().decode(PlayerModel.self, from: data)
                completion(.success(player))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // Obtener los últimos 5 partidos de un jugador
    func fetchLast5Games(playerID: Int, completion: @escaping (Result<[GameLogModel], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/player/\(playerID)/last5games") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Last5GamesResponse.self, from: data)
                completion(.success(decodedResponse.last5Games))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
