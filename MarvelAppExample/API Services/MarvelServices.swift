//
//  MarvelServices.swift
//  MarvelAppExample
//
//  Created by Gabriel Miranda Silveira on 25/05/18.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import Foundation
import Alamofire
import Arcane

class MarvelServices: NSObject {
    
    var successCase: ((AnyObject?) -> (Void)) = { (response) in}
    var failureCase: ((String) -> (Void)) = {(msg) in}
    var alamoFireManager:SessionManager!
    
    private var privateApiKey:String? {
        get {
            return Utils.getValue(fromPlistFile: "MarvelAPI", withKey: "Private API Key")
        }
    }
    
    private var publicApiKey:String? {
        get {
            return Utils.getValue(fromPlistFile: "MarvelAPI", withKey: "Public API Key")
        }
    }
    
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    private func getAuthenticationHash() -> String? {
        guard let privateApiKey = privateApiKey, let publicApiKey = publicApiKey else {
            return nil
        }
        
        let timestamp = NSDate().timeIntervalSince1970
        return Hash.MD5("\(timestamp)\(privateApiKey)\(publicApiKey)")
    }
}
