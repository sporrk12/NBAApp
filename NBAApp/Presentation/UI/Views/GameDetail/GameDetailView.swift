//
//  GameDetailView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetailView: View {
    let gameId: String
    let gameStatus: StatusTypeCategory
    
    @StateObject private var viewModel = GameDetailViewModel(
        getGameDetailUseCase: DependencyInjector.instance.getDependency()!
    )
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                if self.viewModel.gameDetailCatalogAsyncData.isInProgress {
                    ZStack {
                        Color.black.ignoresSafeArea()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                    }
                }
                else{
                    VStack {
                        switch gameStatus {
                        case .pre:
                            PreGameHeaderView(header: self.viewModel.gameDetailCatalogAsyncData.data?.header ?? .defaultValue)
                            Divider()
                            PredictorChartView(
                                predictor: self.viewModel.gameDetailCatalogAsyncData.data?.predictor ?? .defaultValue,
                                teams: self.viewModel.gameDetailCatalogAsyncData.data?.boxscore.teams ?? .defaultValue
                            )
                            .frame(height: 350)
                            
                            LeadersView(leaders: self.viewModel.gameDetailCatalogAsyncData.data?.leaders ?? .defaultValue, isPreGame: true)
                            
                            
                            LastFiveGamesView(lastFiveGames: self.viewModel.gameDetailCatalogAsyncData.data?.lastFiveGames ?? .defaultValue)
                            
                            
                        case .inProgress, .halftime, .finalQuarter:
                            EmptyView()
                            LeadersView(leaders: self.viewModel.gameDetailCatalogAsyncData.data?.leaders ?? .defaultValue, isPreGame: true)
                            
                        case .final:
                            EmptyView()
                            LeadersView(leaders: self.viewModel.gameDetailCatalogAsyncData.data?.leaders ?? .defaultValue, isPreGame: true)
                            
                        case .unknown:
                            EmptyView()
                        }
                        
                        VenueInformationView(venue: self.viewModel.gameDetailCatalogAsyncData.data?.venue ?? .defaultValue)
                    }
                }
            }
            
        }
        .onAppear {
            self.viewModel.getGameDetail(gameId: gameId)
        }
    }
    
    @ViewBuilder
    func PreGameHeaderView(header: HeaderModel, isPreGame: Bool) -> some View {
        
        
        ZStack() {
            if isPreGame {
                VStack(spacing: 5){
                    
                    Text(header.competitions.items.first?.date.convertUTCtoDate() ?? .defaultValue)
                    
                    Text(header.competitions.items.first?.date.convertUTCtoCSTTime() ?? .defaultValue)
                }
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top)
                
            }
//            else{
//                VStack{
//                    Text(header.competitions.items.first?)
//
//                    Text()
//                }
//            }

            
            
            HStack {
                ForEach (header.competitions.items.first?.competitors.items ?? [], id: \.team.id) { competitor in
                    VStack{
                        WebImage(url: URL(string: competitor.team.logos.items[5].href))
                            .resizable()
                            .frame(width: 70, height: 70)
                        
                        Text(competitor.team.name)
                        
                        Text(competitor.records.items[0].summary)
                        
                        
                    }
                    .padding(.horizontal, 60)

                }
            }
            
        }
    }
    
}

#Preview {
    GameDetailView(gameId: "401705562", gameStatus: .pre)
}




import SwiftUI

struct GameStatsView: View {
    let gameData: GameData
    @State private var selectedTab = 1 // Tabla de puntos selected by default
    @State private var showDetailedView = true
    
    var body: some View {
        VStack(spacing: 0) {
            // Game header
            GameHeaderView(homeTeam: gameData.homeTeam, awayTeam: gameData.awayTeam)
            
            // Tab selector
            TabSelectorView(selectedTab: $selectedTab)
            
            // Toggle for detailed view
            DetailedViewToggle(showDetailedView: $showDetailedView)
            
            // Team selector buttons
            TeamSelectorView()
            
            // Stats header
            StatsHeaderView()
            
            // Player stats list
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(gameData.players) { player in
                        PlayerStatsRow(player: player)
                            .background(Color.black)
                    }
                }
            }
            
            Spacer()
        }
        .background(Color.black)
    }
}

struct GameHeaderView: View {
    let homeTeam: TeamData
    let awayTeam: TeamData
    
    var body: some View {
        VStack(spacing: 8) {
            Text("19/03/25 • 8:00p.m.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top)
            
            HStack(alignment: .center, spacing: 20) {
                VStack {
                    Image(homeTeam.logoName)
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text(homeTeam.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(homeTeam.wins)-\(homeTeam.losses)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                VStack {
                    HStack(alignment: .center, spacing: 10) {
                        Text("\(homeTeam.score)")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        Text("-")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.gray)
                        Text("\(awayTeam.score)")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.gray)
                    }
                    Text("Terminado")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                
                VStack {
                    Image(awayTeam.logoName)
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text(awayTeam.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(awayTeam.wins)-\(awayTeam.losses)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.bottom)
        .background(Color.black)
    }
}

struct TabSelectorView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            TabButton(title: "Detalles", isSelected: selectedTab == 0) {
                selectedTab = 0
            }
            TabButton(title: "Tabla de puntos", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            TabButton(title: "Estadísticas", isSelected: selectedTab == 2) {
                selectedTab = 2
            }
            TabButton(title: "Clasificacion", isSelected: selectedTab == 3) {
                selectedTab = 3
            }
        }
        .padding(.vertical, 8)
        .background(Color(UIColor.darkGray).opacity(0.3))
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : .gray)
                .padding(.vertical, 8)
        }
        .overlay(
            Rectangle()
                .frame(height: 3)
                .foregroundColor(isSelected ? .white : .clear)
                .offset(y: 16),
            alignment: .bottom
        )
    }
}

struct DetailedViewToggle: View {
    @Binding var showDetailedView: Bool
    
    var body: some View {
        HStack {
            Text("Apariencia de tabla de puntajes")
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: $showDetailedView)
                .labelsHidden()
        }
        .padding()
        .background(Color.black)
        
        HStack {
            Text("Vista detallada")
                .font(.subheadline)
                .foregroundColor(.blue)
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.black)
    }
}

struct TeamSelectorView: View {
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {}) {
                HStack {
                    Image("lakers_logo")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Spacer()
                }
                .padding()
                .background(Color(UIColor.darkGray).opacity(0.5))
            }
            
            Button(action: {}) {
                HStack {
                    Spacer()
                    Image("lakers_logo")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("+")
                        .foregroundColor(.white)
                    Image("nuggets_logo")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Spacer()
                }
                .padding()
                .background(Color.black)
            }
            
            Button(action: {}) {
                HStack {
                    Spacer()
                    Image("nuggets_logo")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding()
                .background(Color.black)
            }
        }
        .foregroundColor(.white)
    }
}

struct StatsHeaderView: View {
    var body: some View {
        HStack {
            Text("Leyenda")
                .foregroundColor(.blue)
                .font(.system(size: 15))
                .frame(width: 80, alignment: .leading)
            
            Spacer()
            
            HStack(spacing: 12) {
                StatHeader(title: "MIN")
                StatHeader(title: "PTS", isSelected: true)
                StatHeader(title: "REB")
                StatHeader(title: "AST")
                StatHeader(title: "STL")
                StatHeader(title: "BLK")
                StatHeader(title: "FP")
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color(UIColor.darkGray).opacity(0.3))
    }
}

struct StatHeader: View {
    let title: String
    var isSelected: Bool = false
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 14, weight: isSelected ? .bold : .regular))
                .foregroundColor(isSelected ? .blue : .gray)
            
            if isSelected {
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.system(size: 10))
                    .foregroundColor(.blue)
            }
        }
    }
}

struct PlayerStatsRow: View {
    let player: PlayerData
    
    var body: some View {
        HStack {
            // Player info
            VStack(alignment: .leading, spacing: 4) {
                Text(player.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                
                HStack(spacing: 5) {
                    Text(player.number)
                        .foregroundColor(.gray)
                    Text(player.position)
                        .foregroundColor(.gray)
                }
                .font(.system(size: 14))
            }
            .frame(width: 140, alignment: .leading)
            
            Spacer()
            
            // Stats
            HStack(spacing: 15) {
                StatValue(value: player.minutes)
                StatValue(value: player.points, isHighlighted: true)
                StatValue(value: player.rebounds)
                StatValue(value: player.assists)
                StatValue(value: player.steals)
                StatValue(value: player.blocks)
                StatValue(value: player.fouls)
            }
            
            // Rating
            ZStack {
                Rectangle()
                    .fill(ratingColor(player.rating))
                    .frame(width: 40, height: 30)
                
                Text(String(format: "%.1f", player.rating))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color.black)
        .border(width: 0.5, edges: [.bottom], color: Color.gray.opacity(0.3))
    }
    
    func ratingColor(_ rating: Double) -> Color {
        if rating >= 8.0 {
            return Color.teal
        } else if rating >= 7.0 {
            return Color.blue
        } else {
            return Color.yellow
        }
    }
}

struct StatValue: View {
    let value: String
    var isHighlighted: Bool = false
    
    var body: some View {
        Text(value)
            .font(.system(size: 16, weight: isHighlighted ? .bold : .regular))
            .foregroundColor(isHighlighted ? .blue : .white)
            .frame(width: 25, alignment: .center)
    }
}

// Model structures
struct GameData {
    let homeTeam: TeamData
    let awayTeam: TeamData
    let players: [PlayerData]
}

struct TeamData: Identifiable {
    let id = UUID()
    let name: String
    let logoName: String
    let wins: Int
    let losses: Int
    let score: Int
}

struct PlayerData: Identifiable {
    let id = UUID()
    let name: String
    let number: String
    let position: String
    let minutes: String
    let points: String
    let rebounds: String
    let assists: String
    let steals: String
    let blocks: String
    let fouls: String
    let rating: Double
}

// Helper extensions
struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var line = Edge.Set()
            switch edge {
            case .top: line = .top
            case .leading: line = .leading
            case .bottom: line = .bottom
            case .trailing: line = .trailing
            }
            path.addPath(Path(CGRect(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).stroke(color, lineWidth: width))
    }
}

// Preview
struct GameStatsView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatsView(gameData: sampleGameData)
            .preferredColorScheme(.dark)
    }
    
    static var sampleGameData: GameData {
        let lakers = TeamData(name: "Lakers", logoName: "lakers_logo", wins: 42, losses: 25, score: 120)
        let nuggets = TeamData(name: "Nuggets", logoName: "nuggets_logo", wins: 44, losses: 25, score: 108)
        
        let players = [
            PlayerData(name: "L. Dončić", number: "77", position: "F-G", minutes: "32'", points: "31", rebounds: "8", assists: "7", steals: "2", blocks: "1", fouls: "3", rating: 8.3),
            PlayerData(name: "A. Reaves", number: "15", position: "G", minutes: "36'", points: "22", rebounds: "5", assists: "8", steals: "2", blocks: "1", fouls: "2", rating: 8.2),
            PlayerData(name: "D. Finney-Smith", number: "17", position: "F", minutes: "30'", points: "14", rebounds: "4", assists: "4", steals: "1", blocks: "0", fouls: "1", rating: 8.0),
            PlayerData(name: "D. Knecht", number: "4", position: "G", minutes: "25'", points: "12", rebounds: "3", assists: "1", steals: "0", blocks: "0", fouls: "1", rating: 6.7),
            PlayerData(name: "G. Vincent", number: "7", position: "G", minutes: "23'", points: "12", rebounds: "0", assists: "1", steals: "0", blocks: "0", fouls: "2", rating: 6.8),
            PlayerData(name: "J. Vanderbilt", number: "2", position: "F", minutes: "18'", points: "10", rebounds: "2", assists: "1", steals: "3", blocks: "0", fouls: "2", rating: 6.9),
            PlayerData(name: "J. Goodwin", number: "30", position: "G", minutes: "26'", points: "8", rebounds: "3", assists: "3", steals: "4", blocks: "0", fouls: "0", rating: 7.0),
            PlayerData(name: "J. Hayes", number: "9", position: "C", minutes: "21'", points: "6", rebounds: "7", assists: "0", steals: "1", blocks: "1", fouls: "1", rating: 6.6)
        ]
        
        return GameData(homeTeam: lakers, awayTeam: nuggets, players: players)
    }
}
