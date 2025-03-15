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
    @StateObject private var viewModel = LiveScoresViewModel(
        getGamesByDateUseCase: DependencyInjector.instance.getDependency()!
    )
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.gameByDayScoresAsyncData.isInProgress {
                    
                    ZStack {
                        Color.black.ignoresSafeArea()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                    }
                } else {
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 10) {
                            
                            
                            WeekCalendarView(
                                selectedDate: self.$selectedDate
                            )
                            .frame(height: 70)
                            
                            ForEach(self.viewModel.gameByDayScoresAsyncData.data?.items ?? [], id: \.id) { game in
                                LiveGameRowView(game: game)
                            }
                        }
                        .padding()
                    }
                    
                }
            }
            .navigationTitle("NBA Scoreboard")
            .refreshable {
                self.refreshLiveScores()
            }
            .onChange(of: selectedDate) { oldDate, newDate in
                self.viewModel.getGamesByDate(date: newDate.toString())
                
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            self.refreshLiveScores()
        }
    }
    
    private func refreshLiveScores() {
        self.viewModel.getGamesByDate(date: selectedDate.toString())
    }
}

#Preview {
    LiveScoresView()
}

