//
//  CharacterMO.swift
//  RickAndMortyCharacters
//
//  Created by Dmytro Kmytiuk on 03.05.2024.
//

import RealmSwift

final class CharacterObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var status: String
    @Persisted var species: String
    @Persisted var gender: String
    @Persisted var image: String
    @Persisted var origin: String
    @Persisted var location: String
}
