//
//  Serie.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 28/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import Foundation
import Gloss

class Serie: MarvelCollection {
    
    var id: Int?
    var title: String?
    var description: String?
    var thumbnail: String?
    var type = MarvelCollectionType.Series
    
    required init(json: JSON) {
        if let id = json["id"] as? Int {
            self.id = id
        }
        
        if let title = json["title"] as? String {
            self.title = title
        }
        
        if let description = json["description"] as? String {
            self.description = description
        }
        
        if let thumb = json["thumbnail"] as? JSON {
            if let imgUrl = thumb["path"] as? String, let imgExtension = thumb["extension"] as? String {
                self.thumbnail = "\(imgUrl).\(imgExtension)"
            }
        }
    }
    
}
