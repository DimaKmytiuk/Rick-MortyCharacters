//
//  RealmManager.swift
//  RickAndMortyCharacters
//
//  Created by Dmytro Kmytiuk on 02.05.2024.
//

import Foundation
import RealmSwift

struct RealmManager {
    
    func saveCharacters(_ characters: [Character] ) {
        let characterObjects = characters.map { character in
            let characterObject = CharacterObject()
            characterObject.id = character.id
            characterObject.name = character.name
            characterObject.status = character.status
            characterObject.species = character.species
            characterObject.gender = character.gender
            characterObject.origin = character.origin.name
            characterObject.location = character.location.name
            characterObject.image = character.image
            return characterObject
        }
        
        do {
            let realm = try Realm()
            let existingIds = Set(realm.objects(CharacterObject.self).map { $0.id })
            let newCharacterObjects = characterObjects.filter { !existingIds.contains($0.id) }
            try realm.write {
                realm.add(newCharacterObjects, update: .modified)
            }
        } catch {
            debugPrint("Error")
        }
    }
    
    func loadCharacters() -> [Character] {
        var characters: [Character] = []
        do {
            let realm = try Realm()
            let characterObjects = realm.objects(CharacterObject.self)
            characters = characterObjects.map { characterObject in
                Character(id: characterObject.id,
                          name: characterObject.name,
                          status: characterObject.status,
                          species: characterObject.species,
                          gender: characterObject.gender,
                          origin: Origin(name: characterObject.origin),
                          location: Location(name:characterObject.location),
                          image: characterObject.image)
            }
        } catch {
            debugPrint("Error loading characters from Realm: \(error)")
        }
        return characters
    }
}
