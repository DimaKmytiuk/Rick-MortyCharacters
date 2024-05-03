//
//  CharacterDetailView.swift
//  RickAndMortyCharacters
//
//  Created by Dmytro Kmytiuk on 01.05.2024.
//

import SwiftUI
import ComposableArchitecture
import NukeUI

struct CharacterDetailView: View {
    let store: StoreOf<CharacterDetailFeature>
    
    var body: some View {
        GeometryReader { screen in
            VStack {
                Text(store.chatacter.name)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(Color.white)
                    .padding(.top)
                
                HStack {
                    Spacer()
                    
                    LazyImage(url: URL(string: store.chatacter.image))
                        .cornerRadius(25)
                        .onAppear {
                            print(store.chatacter.image)
                        }
                    
                    Spacer()
                }
                
                constructInfoView()
                    .padding(.leading, 20)
                
                Spacer()
                
                    Button {
                        store.send(.closeScreen)
                    } label: {
                        Text("Dismiss")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.red)
                    }
                }
            }
            .background(.cyan)
    }
}

private extension CharacterDetailView {
    func constructInfoView() -> some View {
        VStack {
            HStack {
                Text("Status:")
                    .foregroundColor(Color.white)
                    .font(.system(size: 18, weight: .medium))
                
                Text(store.chatacter.status)
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
            }
            HStack {
                Text("Species:")
                    .foregroundColor(Color.white)
                    .font(.system(size: 18, weight: .medium))
                
                Text(store.chatacter.species)
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
            }
            HStack {
                Text("Gender:")
                    .foregroundColor(Color.white)
                    .font(.system(size: 18, weight: .medium))
                
                Text(store.chatacter.gender)
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
            }
            HStack {
                Text("Origin:")
                    .foregroundColor(Color.white)
                    .font(.system(size: 18, weight: .medium))
                
                Text(store.chatacter.origin.name)
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
            }
            HStack {
                Text("Location:")
                    .foregroundColor(Color.white)
                    .font(.system(size: 18, weight: .medium))
                
                Text(store.chatacter.location.name)
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
            }
        }
    }
}
