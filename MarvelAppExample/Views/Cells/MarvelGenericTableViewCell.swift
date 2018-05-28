//
//  MarvelGenericTableViewCell.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 27/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import UIKit

class MarvelGenericTableViewCell: UITableViewCell {

    static let nibName = "MarvelGenericTableViewCell"
    static let identifier = "marvelGenericTableViewCellIdentifier"
    
    @IBOutlet weak var thumbImageView: UIImageView! {
        didSet {
            thumbImageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var titleLable: UILabel! {
        didSet {
            titleLable.textColor = UIColor.white
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = "No description"
            descriptionLabel.textColor = UIColor.white
        }
    }
    
    func configure(withMarvelCollection collection:MarvelCollection) {
        if let thumbnail = collection.thumbnail, let thumbnailUrl = URL(string: thumbnail) {
            thumbImageView.sd_setImage(with: thumbnailUrl, completed: nil)
        }
        
        if let title = collection.title {
            titleLable.text = title
        }
        
        if let description = collection.description {
            descriptionLabel.text = description
        }
        
        contentView.backgroundColor = Colors.blackMarvel
    }
}
