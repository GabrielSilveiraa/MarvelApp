//
//  MarvelServicesCrypto.swift
//  MarvelAppExample
//
//  Created by Gabriel Silveira on 27/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import Foundation
import Arcane

struct MarvelServicesCrypto {
    static private var privateApiKey:String? {
        get {
            return Utils.getValue(fromPlistFile: "MarvelAPI", withKey: "Private API Key")
        }
    }
    
    static private var publicApiKey:String? {
        get {
            return Utils.getValue(fromPlistFile: "MarvelAPI", withKey: "Public API Key")
        }
    }
    
    static func getAuthentication() -> String? {
        guard let publicKey = publicApiKey, let privateKey = privateApiKey else {
            return nil
        }

        let timestamp = Int(NSDate().timeIntervalSince1970)

        guard let hash = Hash.MD5("\(timestamp)\(privateKey)\(publicKey)") else {
            return nil
        }
        return "ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)"
    }
    
}
