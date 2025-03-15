//
//  LiveScoresViewModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation
import Combine

@MainActor
class LiveScoresViewModel: ViewModel {
    @Published var gameByDayScoresAsyncData: AsyncDataModel<CountedListModel<EventModel>> = .defaultValue
    
    private var getGamesByDateUseCase: GetGamesByDateUseCase
    
    
    init(getGamesByDateUseCase: GetGamesByDateUseCase) {
        self.getGamesByDateUseCase = getGamesByDateUseCase
        super.init()
        let todayString = Date().toString()
        self.getGamesByDate(date: todayString)

    }
    
    func getGamesByDate(date: String) {
        Task {
            do {
                self.gameByDayScoresAsyncData = .inProgress(data: EventModel.shimmerValues)
                
                let gameScoresResponse: GetGamesByDateUseCase.Response = try await self.getGamesByDateUseCase.execute(params: .init(date: date))
                
                let gameScoresEntity: CountedListModel<EventModel> = EventModel.toList(fromData: gameScoresResponse.events)
                
                self.gameByDayScoresAsyncData = .success(data: gameScoresEntity)
            } catch {
                self.handleError(error)
                self.gameByDayScoresAsyncData = .failure(error)
            }
        }
    }
    
}
