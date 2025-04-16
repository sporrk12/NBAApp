//
//  TeamsViewModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import Foundation

@MainActor
class TeamsViewModel: ViewModel {
    @Published var teamsAsyncData: AsyncDataModel<SportModel> = .defaultValue
    
    private var getTeamsUseCase: GetTeamsUseCase
    
    init(getTeamsUseCase: GetTeamsUseCase) {
        self.getTeamsUseCase = getTeamsUseCase
        super.init()
        self.getTeams()
        
    }
    
    func getTeams() {
        Task {
            do {
                self.teamsAsyncData = .inProgress(data: SportModel.shimmerValue)
                
                let teamsResponse: GetTeamsUseCase.Response = try await self.getTeamsUseCase.execute(params: GetTeamsUseCase.Params())
                
                let teamsEntity: SportModel = .toObject(fromData: teamsResponse.sport)
                
                self.teamsAsyncData = .success(data: teamsEntity)
            } catch {
                self.handleError(error)
                self.teamsAsyncData = .failure(error)
            }
        }
    }
    
}
