//
//  NBAAppApp.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 24/01/25.
//

import SwiftUI

@main
struct NBAAppApp: App {
    
    init() {
        DependencyInjector.instance.injectDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
