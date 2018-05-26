//
//  Character.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 26/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import Foundation
import Gloss

class Character: JSONDecodable {
    
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: String?
//    var comics: [Comic] = []
//    var stories: [Storie] = []
//    var events: [Event] = []
//    var series: [Serie] = []
    
    required init?(json:JSON) {
        if let id = json["id"] as? Int {
            self.id = id
        }
        
        if let name = json["name"] as? String {
            self.name = name
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
