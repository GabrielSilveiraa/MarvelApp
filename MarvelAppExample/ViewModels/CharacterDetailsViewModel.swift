//
//  CharacterDetailsViewModel.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 26/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import Foundation

class CharacterDetailsViewModel: NSObject {

    var character:Character
    var thumbnailUrl:URL?
    
    init(withCharacter character:Character) {
        self.character = character
        
        if let thumbnail = character.thumbnail {
            self.thumbnailUrl = URL(string: thumbnail)
        }
    }
    
}
