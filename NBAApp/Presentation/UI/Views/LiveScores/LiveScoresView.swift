//
//  LiveScoresView.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import SwiftUI

struct LiveScoresView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var selectedDate: Date = Date()
    @State private var selectedGame: EventModel?
    @StateObject private var viewModel = LiveScoresViewModel(
        getGamesByDateUseCase: DependencyInjector.instance.getDependency()!
    )
    
    var body: some View {
        NavigationStack {
            Group {
                if self.viewModel.gameByDayScoresAsyncData.isInProgress {
                    LoadingView()
                }else {
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 35) {
                            WeekCalendarView(
                                selectedDate: self.$selectedDate
                            )
                            .frame(height: 35)
                            
                            ForEach(self.viewModel.gameByDayScoresAsyncData.data?.items ?? [], id: \.id) { game in
                                NavigationLink(
                                    destination:
                                        GameDetailView(
                                            gameId: game.id,
                                            gameStatus: game.status.type.typeCategory
                                        )
                                ){
                                    LiveGameRowView(game: game)
                                }
                            }
                            .simultaneousGesture(
                                DragGesture()
                                    .onEnded { value in
                                        let horizontalAmount = value.translation.width
                                        
                                        if horizontalAmount > 70 {
                                            self.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: self.selectedDate) ?? self.selectedDate
                                        } else if horizontalAmount < -70 {
                                            self.selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: self.selectedDate) ?? self.selectedDate
                                        }
                                    }
                            )
                        }
                    }
                    .padding(.top, 10)
                }
            }
            .navigationTitle("Game Schedule")
            .refreshable {
                self.refreshLiveScores()
            }
            .onChange(of: self.selectedDate) { oldDate, newDate in
                self.refreshLiveScores()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            self.refreshLiveScores()
        }
        
    }
    
    private func refreshLiveScores() {
        self.viewModel.getGamesByDate(date: self.selectedDate.toString())
    }
}

#Preview {
    LiveScoresView()
}

