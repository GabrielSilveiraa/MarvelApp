//
//  ComicsViewModel.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 27/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import Foundation
import Gloss

protocol ComicsViewModelDelegate {
    func didLoadComics()
}

class ComicsViewModel: NSObject {
    
    var delegate:ComicsViewModelDelegate?
    private var characterId: Int?
    var comics = [Comic]()
    
    init(withCharacter character:Character) {
        super.init()
        characterId = character.id
        loadComics()
    }
    
    private func loadComics() {
        guard let characterId = characterId else {
            return
        }
        
        MarvelServices.shared.getComics(forCharacterId: characterId) { response, error in
            if let response = response as? JSON {
                if let results = response["results"] as? [JSON] {
                    for comic in results {
                        if let newComic = Comic(json: comic) {
                            self.comics.append(newComic)
                        }
                    }
                    self.delegate?.didLoadComics()
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
