//
//  LiveGamesView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 27/01/25.
//
import SwiftUI

struct LiveGamesView: View {
    @State private var games: [GameModel] = []
    @State private var selectedDate: Date = Date()
    @State private var isLoading: Bool = true
    @State private var errorMessage: String?
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    private func loadGamesForDate(date: Date) {
        isLoading = true
        let formattedDate = dateFormatter.string(from: date)
        
        NBAService.shared.fetchGames(for: formattedDate) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let response):
                    games = response.games
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Partidos del día")
                    .font(.title)
                    .bold()
                // 📅 Agregar el calendario deslizable
                CalendarView(selectedDate: $selectedDate)
                    .frame(height: 120)
                    .padding(.top, 10)
                Divider()
                    .background(Color.teal)
                
                    .padding(16)
                ScrollView(showsIndicators: false) {
                    
                    if isLoading {
                        ProgressView("Cargando partidos...")
                        
                    } else {
                        if games.isEmpty {
                            Text("No hay partidos disponibles para esta fecha.")
                                .foregroundColor(.gray)
                        } else {
                            
                            ForEach(games, id: \.id){ game in
                                NavigationLink(destination: BoxScoreView(gameID: game.id)) {
                                    
                                    VStack{
                                        GameView(game: game)
                                        Divider()
                                            .background(Color.teal)
                                            .padding(16)
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .foregroundStyle(Color.white)
            .onAppear {
                loadGamesForDate(date: selectedDate)
            }
            .onChange(of: selectedDate) { date, newDate in
                loadGamesForDate(date: newDate)
            }
        }
        
    }
}
#Preview {
    LiveGamesView()
}

//
////
////  LocationPickerButton.swift
////  EnviaFlores
////
////  Created by Emmanuel  Granados on 10/12/24.
////
//
//import SwiftUI
//
//struct LocationPickerButton: View {
//    @EnvironmentObject private var deliveryLocationsManager: DeliveryLocationsManager
//
//    @State private var isLocationPresented = false
//    @State private var isCalendarPresented = false
//
//    var cityName: String { self.deliveryLocationsManager.selectedCity.data?.name ?? "" }
//
//    var body: some View {
//        HStack(spacing: 0) {
//            Button {
//                self.isLocationPresented = true
//            } label: {
//                HStack {
//                    Image(Resources.iconTruckFast)
//                        .resizable()
//                        .frame(width: 18.0, height: 18.0)
//                        .scaledToFit()
//
//                    Text(self.cityName)
//                        .foregroundStyle(Colors.blackPrimary)
//                        .font(Font(Fonts.overline.regular400))
//                        .multilineTextAlignment(.leading)
//                    Spacer()
//                }
//                .frame(maxWidth: .infinity)
//
//            }
//            .popover(isPresented: self.$isLocationPresented) {
//                DeliveryLocationsScreen()
//            }
//            .padding(.horizontal)
//
//            Rectangle()
//                .foregroundColor(Colors.grayOutline)
//                .frame(width: 1.0, height: 52)
//
//            Button {
//                self.isCalendarPresented = true
//            } label: {
//                HStack {
//                    Image(Resources.iconCalendarMonthOutline)
//                        .resizable()
//                        .frame(width: 18.0, height: 18.0)
//                        .scaledToFit()
//
//                    Text("input_when")
//                        .foregroundStyle(Colors.blackPrimary)
//                        .font(Font(Fonts.overline.regular400))
//                        .multilineTextAlignment(.leading)
//
//                    Spacer()
//                }
//                .frame(maxWidth: .infinity)
//            }
//            .popover(isPresented: self.$isCalendarPresented) {
//                CalendarScreen()
//            }
//            .padding(.horizontal)
//        }
//        .frame(maxWidth: .infinity, maxHeight: 60.0)
//        .background(Colors.grayInactive)
//        .cornerRadius(30.0)
//    }
//}
//
//#Preview {
//    LocationPickerButton()
//}
//
