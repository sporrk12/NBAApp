//
//  DependencyInjector.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

class DependencyInjector {
    nonisolated(unsafe) static let instance: DependencyInjector = DependencyInjector()
    private var dependencies: [String: Any] = [:]
    
    private init() {}
    
    private func registerSingletonDependency<T>(_ service: T, key: String? = nil) {
        let key: String = key ?? "\(T.self)"
        self.dependencies[key] = service
    }
    
    private func registerDependency<T>(_ factory: () -> T, key: String? = nil) {
        let key: String = key ?? "\(T.self)"
        self.dependencies[key] = factory()
    }
    
    func getDependency<T>(key: String? = nil) -> T? {
        let key: String = key ?? "\(T.self)"
        
        if let singletonDependency: T = self.dependencies[key] as? T {
            return singletonDependency
        } else if let dependency: () -> T = self.dependencies[key] as? () -> T {
            return dependency()
        }
        
        return nil
    }
    
    func injectDependencies() {
        self.injectSources()
        self.injectRepositories()
        self.injectUseCases()
    }
    
    private func injectSources() {
        
        self.registerDependency({ HttpDataSource(host: Constants.baseUrl) as DataSource }, key: "HttpDataSource")
    }
    
    private func injectRepositories() {
        let httpDataSource: DataSource = self.getDependency(key: "HttpDataSource")!
        
        self.registerDependency({ GetGamesByDateDataSourceRemoteRepository(dataSource: httpDataSource) as GetGamesByDateRemoteRepository})
        
        self.registerDependency({ GetGameDetailDataSourceRemoteRepository(dataSource: httpDataSource) as GetGameDetailRemoteRepository})
    }
    
    private func injectUseCases() {
        
        self.registerDependency({ GetGamesByDateUseCase(
            getGamesByDateRemoteRepository: self.getDependency()!)
        })
        
        self.registerDependency({ GetGameDetailUseCase(
            getGameDetailRemoteRepository: self.getDependency()!)
        })
    }
}



