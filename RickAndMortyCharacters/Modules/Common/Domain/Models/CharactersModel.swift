//
//  CharacterModel.swift
//  RickAndMortyCharacters
//
//  Created by Dmytro Kmytiuk on 02.05.2024.
//

import Foundation

struct Characters: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
}

struct Origin: Codable {
    let name: String
}

struct Location: Codable {
    let name: String
}

