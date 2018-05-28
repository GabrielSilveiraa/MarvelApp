//
//  Utils.swift
//  MarvelAppExample
//
//  Created by Gabriel Miranda Silveira on 25/05/18.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import Foundation

struct Utils {
    
    static func getValue(fromPlistFile plistFile:String, withKey key:String) -> String? {
        guard let path = Bundle.main.path(forResource: plistFile, ofType: "plist") else{
            return nil
        }
        if let plistDictionary = NSDictionary(contentsOfFile: path) {
            return plistDictionary[key] as? String
        }
        return nil
    }
}
