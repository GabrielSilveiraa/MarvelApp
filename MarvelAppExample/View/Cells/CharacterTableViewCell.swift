//
//  CharacterTableViewCell.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 26/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    static let nibName = "CharacterTableViewCell"
    
    @IBOutlet weak var characterNameLabel: UILabel!
    
    func configure(withCharacter character:Character) {
        characterNameLabel.text = character.name
    }
}
