//
//  MarvelButton.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 28/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import UIKit

class MarvelButton: UIButton {

    override func awakeFromNib() {
        self.backgroundColor = Colors.redMarvel
        self.layer.cornerRadius = 4
        self.setTitleColor(UIColor.white, for: .normal)
    }

}
