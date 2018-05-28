//
//  MarvelModel.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 28/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import Foundation
import Gloss

enum MarvelCollectionType: Int {
    case Comics = 1
    case Stories
    case Events
    case Series
    
    var toString:String {
        get {
            switch self {
            case .Comics:
                return "Comics"
            case .Stories:
                return "Stories"
            case .Events:
                return "Events"
            case .Series:
                return "Series"
            }
        }
    }
}

protocol MarvelCollection: JSONDecodable {

    var id: Int? {get}
    var title: String? {get}
    var description: String? {get}
    var thumbnail: String? {get}
    var type:MarvelCollectionType {get}
    
    init(json: JSON)
    
}
