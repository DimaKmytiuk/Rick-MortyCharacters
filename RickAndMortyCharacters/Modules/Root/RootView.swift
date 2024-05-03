//
//  RootView.swift
//  RickAndMortyCharacters
//
//  Created by Dmytro Kmytiuk on 01.05.2024.
//

import SwiftUI
import ComposableArchitecture
import NukeUI

struct RootView: View {
    @Perception.Bindable var store: StoreOf<RootFeature>
    
    var body: some View {
        GeometryReader { screen in
            VStack {
                List {
                    ForEach(store.characters, id: \.id) { character in
                        constructCharacterCell(character: character, screen: screen)
                            .onAppear {
                                if let lastItem =
                                    store.state.characters.last,
                                   character.id == lastItem.id {
                                    store.send(.loadCharacters)
                                }
                            }
                            .onTapGesture {
                                store.send(.showDetailScreen(character))
                            }
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.cyan)
                            .background(Color.clear)
                            .padding(
                                EdgeInsets(
                                    top: 4,
                                    leading: 0,
                                    bottom: 4,
                                    trailing: 0
                                )
                            )
                    )
                }
                .background(Color.clear)
                .onAppear {
                    store.send(.loadCharacters)
                }
                if store.isLoading {
                    ProgressView()
                }
            }
            .navigationTitle("List of Characters")
            .sheet(item: $store.scope(state: \.currentCharacter, action: \.detailCharacter)) { store in
                CharacterDetailView(store: store)
            }
        }
    }
}

private extension RootView {
    func constructCharacterCell(character: Character, screen: GeometryProxy) -> some View {
        HStack {
            VStack {
                HStack {
                    Text("Name:")
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .medium))
                    
                    Text(character.name)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                }
                HStack(alignment: .firstTextBaseline) {
                    Text("Gender:")
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .medium))
                    
                    Text(character.gender)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                }
                HStack {
                    Text("Species:")
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .medium))
                    
                    Text(character.species)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                }
            }
            
            LazyImage(url: URL(string: character.image))
                .frame(width: 150, height: 150)
                .cornerRadius(25)
        }
        .frame(height: 150)
    }
}
