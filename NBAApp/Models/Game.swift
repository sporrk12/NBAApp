////
////  Game.swift
////  NBAApp
////
////  Created by Emmanuel  Granados on 26/01/25.
////
//
//import Foundation
//
//struct Last5GamesResponse: Codable {
//    let playerID: String
//    let last5Games: [GameStat]
//
//    enum CodingKeys: String, CodingKey {
//        case playerID = "player_id"
//        case last5Games = "last_5_games"
//    }
//}
//
//struct GameStat: Codable {
//    let date: String
//    let points: Int
//    let rebounds: Int
//    let assists: Int
//    let homeTeam: String
//    let awayTeam: String
//    let homeTeamLogo: String
//    let awayTeamLogo: String
//
//    enum CodingKeys: String, CodingKey {
//        case date = "date"
//        case points = "points"
//        case rebounds = "rebounds"
//        case assists = "assists"
//        case homeTeam = "homeTeam"
//        case awayTeam = "awayTeam"
//        case homeTeamLogo = "homeTeamLogo"
//        case awayTeamLogo = "awayTeamLogo"
//    }
//}
//
//struct LiveGamesResponse: Codable {
//    let gameDate: String
//    let games: [LiveGame]
//
//    enum CodingKeys: String, CodingKey {
//        case gameDate = "game_date"
//        case games
//    }
//}
//
//struct LiveGame: Codable {
//    let gameID: String
//    let gameDate: String
//    let gameStatus: Int
//    let gameStatusText: String
//    let period: Int
//    let gameClock: String
//    let homeTeam: Team
//    let awayTeam: Team
//
//    enum CodingKeys: String, CodingKey {
//        case gameID = "game_id"
//        case gameDate = "game_date"
//        case gameStatus = "game_status"
//        case gameStatusText = "game_status_text"
//        case period
//        case gameClock = "game_clock"
//        case homeTeam = "home_team"
//        case awayTeam = "away_team"
//    }
//}
//
//struct TeamDetails: Codable {
//    let teamCity: String
//    let teamName: String
//    let teamTricode: String
//    let score: Int
//    let logoURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case teamCity = "team_city"
//        case teamName = "team_name"
//        case teamTricode = "team_tricode"
//        case score
//        case logoURL = "logo_url"
//    }
//}
//
//struct Meta: Codable {
//    let code: Int
//    let request: String
//    let time: String
//    let version: Int
//}
//
//struct Scoreboard: Codable {
//    let gameDate: String
//    let games: [Game]
//    let leagueId: String
//    let leagueName: String
//}
//
//struct Game: Codable {
//    let awayTeam: Team
//    let homeTeam: Team
//    let gameClock: String
//    let gameCode: String
//    let gameId: String
//    let gameStatus: Int
//    let gameStatusText: String
//    let period: Int
//}
