//
//  MarvelCollectionViewModel.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 27/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import Foundation
import Gloss

protocol MarvelCollectionViewModelDelegate {
    func didLoadCollection()
}

class MarvelCollectionViewModel {
    
    private var characterId: Int?
    var collectionType: MarvelCollectionType
    var collection = [MarvelCollection]()
    var delegate:MarvelCollectionViewModelDelegate?
    
    init(withCharacter character:Character, andCollection collectionType:MarvelCollectionType) {
        self.characterId = character.id
        self.collectionType = collectionType
        loadCollection()
    }
    
    private func loadCollection() {
        guard let characterId = characterId else {
            return
        }
        
        MarvelServices.shared.getCollection(collection: collectionType, forCharacterId: characterId) { response, error in
            if let response = response as? JSON {
                if let results = response["results"] as? [JSON] {
                    for result in results {
                        
                        var newCollection:MarvelCollection?
                        
                        switch self.collectionType {
                        case MarvelCollectionType.Comics :
                            newCollection = Comic(json: result)
                        case MarvelCollectionType.Events:
                            newCollection = Event(json: result)
                        case MarvelCollectionType.Stories:
                            newCollection = Storie(json: result)
                        case MarvelCollectionType.Series:
                            newCollection = Serie(json: result)
                        }
                        
                        if let newCollection = newCollection {
                            self.collection.append(newCollection)
                        }
                    }
                    self.delegate?.didLoadCollection()
                }
            } else {
                if let error = error {
                    print(error)
                } else {
                    print("Error when loading characters")
                }
            }
        }
    }
    
}
