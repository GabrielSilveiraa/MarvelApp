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
import Gloss

class MarvelServices: NSObject {
    
    static let shared = MarvelServices()
    
    private var alamofireManager:SessionManager!
    
    private var baseUrl:String? {
        get {
            return Utils.getValue(fromPlistFile: "MarvelAPI", withKey: "Base URL")
        }
    }
    
    override private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func getCharacters(withOffset offset:Int, completion: @escaping (Any?, Error?) -> Void) {
        
        guard let baseUrl = baseUrl, let authentication = MarvelServicesCrypto.getAuthentication() else {
            return
        }
        
        guard let url = URL(string: "\(baseUrl)/v1/public/characters?offset=\(offset)&\(authentication)") else {
            return
        }
        
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        alamofireManager.request(urlRequest).responseJSON { (response) in
            guard response.result.isSuccess else {
                completion(nil, response.result.error)
                return
            }
            if let responseJSON = response.result.value as? JSON {
                let data = responseJSON["data"] as? JSON
                completion(data, nil)
            } else {
                completion(response.result.value, nil)
            }
        }
    }
    
    func getCollection(collection: MarvelCollectionType, forCharacterId characterId:Int, completion: @escaping (Any?, Error?) -> Void) {
        
        guard let baseUrl = baseUrl, let authentication = MarvelServicesCrypto.getAuthentication() else {
            return
        }
        
        let collectionChosen = collection.toString.lowercased()
        
        guard let url = URL(string: "\(baseUrl)/v1/public/characters/\(characterId)/\(collectionChosen)?\(authentication)") else {
            return
        }
        
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        alamofireManager.request(urlRequest).responseJSON { (response) in
            guard response.result.isSuccess else {
                completion(nil, response.result.error)
                return
            }
            if let responseJSON = response.result.value as? JSON {
                let data = responseJSON["data"] as? JSON
                completion(data, nil)
            } else {
                completion(response.result.value, nil)
            }
        }
    }
    
}
