//
//  CharactersViewModel.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 26/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import Foundation
import Gloss

protocol CharactersViewModelDelegate {
    func didLoadCharacters()
}

class CharactersViewModel: NSObject {
    
    var characters:[Character]?
    var delegate:CharactersViewModelDelegate?
    
    func loadCharacters() {
        MarvelServices.shared.getCharacters { response, error in
            if let response = response as? JSON {
                if let results = response["results"] as? [JSON] {
                    self.characters = [Character]()
                    for character in results {
                        if let newCharacter = Character(json: character) {
                            self.characters?.append(newCharacter)
                        }
                    }
                    self.delegate?.didLoadCharacters()
                }
            } else {
                print(error)
            }
        }
    }
    
}
