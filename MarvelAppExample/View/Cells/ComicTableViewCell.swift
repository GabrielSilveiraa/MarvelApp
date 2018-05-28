//
//  ComicTableViewCell.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 27/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import UIKit

class ComicTableViewCell: UITableViewCell {

    static let nibName = "ComicTableViewCell"
    
    @IBOutlet weak var comicImageView: UIImageView! {
        didSet {
            comicImageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var comicTitleLable: UILabel!
    
    @IBOutlet weak var comicDescriptionLabel: UILabel! {
        didSet {
            comicDescriptionLabel.text = "No description"
        }
    }
    
    func configure(withComic comic:Comic) {
        if let thumbnail = comic.thumbnail, let thumbnailUrl = URL(string: thumbnail) {
            comicImageView.sd_setImage(with: thumbnailUrl, completed: nil)
        }
        
        if let title = comic.title {
            comicTitleLable.text = title
        }
        
        if let description = comic.description {
            comicDescriptionLabel.text = description
        }
    }
}
