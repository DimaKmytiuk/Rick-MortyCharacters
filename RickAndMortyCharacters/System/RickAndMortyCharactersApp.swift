//
//  RickAndMortyCharactersApp.swift
//  RickAndMortyCharacters
//
//  Created by Dmytro Kmytiuk on 01.05.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct RickAndMortyCharactersApp: App {
    static let store = Store(initialState: RootFeature.State()) {
        RootFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RootView(store: RickAndMortyCharactersApp.store)
            }
        }
    }
}
