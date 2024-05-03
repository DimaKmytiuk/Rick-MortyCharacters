//
//  CharacterDetailFeature.swift
//  RickAndMortyCharacters
//
//  Created by Dmytro Kmytiuk on 01.05.2024.
//

import ComposableArchitecture

@Reducer
struct CharacterDetailFeature {
    @Dependency(\.dismiss) var dismiss

    @ObservableState
    struct State {
        let chatacter: Character
    }
    enum Action {
        case closeScreen
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .closeScreen:
                return .run { send in
                    await self.dismiss()
                }
            }
        }
    }
}
