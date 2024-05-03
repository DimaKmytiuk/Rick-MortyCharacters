//
//  RootFeature.swift
//  RickAndMortyCharacters
//
//  Created by Dmytro Kmytiuk on 01.05.2024.
//

import Foundation
import ComposableArchitecture
import RealmSwift

@Reducer
struct RootFeature {
    private let apiClient = URLSessionAPIClient<RickAndMortyEndpoint>()
    private let realmManager = RealmManager()
    
    @ObservableState
    struct State {
        var characters: [Character] = []
        var isLoading = false
        var currentPage = 1
        
        @Presents
        var currentCharacter: CharacterDetailFeature.State?
    }
    
    enum Action {
        case nextPageOpened
        case loadCharacters
        case setResults([Character])
        case getCharactersFromDB
        case showDetailScreen(Character)
        case detailCharacter(PresentationAction<CharacterDetailFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case let .showDetailScreen(selectedCharacter):
                state.currentCharacter = CharacterDetailFeature.State(chatacter: selectedCharacter)
                return .none
                
            case .loadCharacters: 
                state.isLoading = true
                let page = state.currentPage
                return .run { send in
                    let result: Characters? = try? await apiClient.request(.getCharacters(page: page))
                    if let newCharacters = result?.results, !newCharacters.isEmpty {
                        await send(.nextPageOpened)
                        await send(.setResults(newCharacters))
                    } else {
                        await send(.getCharactersFromDB)
                    }
                }
                
            case .getCharactersFromDB:
                state.characters = realmManager.loadCharacters()
                return .none
                
            case .setResults(let newCharacters):
                state.isLoading = false
                state.characters.append(contentsOf: newCharacters)
                realmManager.saveCharacters(newCharacters)
                return .none
                
            case .nextPageOpened:
                state.currentPage += 1
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$currentCharacter, action: \.detailCharacter) {
            CharacterDetailFeature()
        }
    }
}
