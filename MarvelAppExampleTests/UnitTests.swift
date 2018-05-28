//
//  UnitTests.swift
//  MarvelAppExampleTests
//
//  Created by Gabriel Silveira on 27/05/2018.
//  Copyright © 2018 GabrielSilveira. All rights reserved.
//

import XCTest
import Gloss

class UnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetCharactersServiceWithSuccess() {
        let expec = expectation(description: "Success on getting characters")
        var results:[JSON]?
        
        MarvelServices.shared.getCharacters(withOffset: 0) { response, error in
            if let response = response as? JSON {
                results = response["results"] as? [JSON]
                expec.fulfill()
            } else {
                if let error = error {
                    XCTFail("Error: \(error)")
                } else {
                    XCTFail("Error getting characters")
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(results != nil)
    }
    
    func testErrorOnGetCharactersService() {
        let expec = expectation(description: "Error when offset is negative")
        var results:Any?
        
        MarvelServices.shared.getCharacters(withOffset: -1) { response, _ in
            results = response
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(results)
    }
    
    func testGetComicsServiceWithSuccess() {
        let expec = expectation(description: "Success on getting comics")
        var results:[JSON]?
        
        MarvelServices.shared.getCollection(collection: MarvelCollectionType.Comics, forCharacterId: 1) { response, error in
            if let response = response as? JSON {
                results = response["results"] as? [JSON]
                expec.fulfill()
            } else {
                if let error = error {
                    XCTFail("Error: \(error)")
                } else {
                    XCTFail("Error getting comics")
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(results != nil)
    }
    
    func testGetStoriesServiceWithSuccess() {
        let expec = expectation(description: "Success on getting comics")
        var results:[JSON]?
        
        MarvelServices.shared.getCollection(collection: MarvelCollectionType.Stories, forCharacterId: 1) { response, error in
            if let response = response as? JSON {
                results = response["results"] as? [JSON]
                expec.fulfill()
            } else {
                if let error = error {
                    XCTFail("Error: \(error)")
                } else {
                    XCTFail("Error getting stories")
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(results != nil)
    }
    
    func testGetSeriesServiceWithSuccess() {
        let expec = expectation(description: "Success on getting comics")
        var results:[JSON]?
        
        MarvelServices.shared.getCollection(collection: MarvelCollectionType.Series, forCharacterId: 1) { response, error in
            if let response = response as? JSON {
                results = response["results"] as? [JSON]
                expec.fulfill()
            } else {
                if let error = error {
                    XCTFail("Error: \(error)")
                } else {
                    XCTFail("Error getting series")
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(results != nil)
    }
    
    func testGetEventsServiceWithSuccess() {
        let expec = expectation(description: "Success on getting comics")
        var results:[JSON]?
        
        MarvelServices.shared.getCollection(collection: MarvelCollectionType.Events, forCharacterId: 1) { response, error in
            if let response = response as? JSON {
                results = response["results"] as? [JSON]
                expec.fulfill()
            } else {
                if let error = error {
                    XCTFail("Error: \(error)")
                } else {
                    XCTFail("Error getting events")
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(results != nil)
    }
    
    func testErrorOnGetCollectionService() {
        let expec = expectation(description: "Error when id is zero")
        var results: Any?
        
        MarvelServices.shared.getCollection(collection: MarvelCollectionType.Comics, forCharacterId: 0) { response, error in
            results = response
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(results)
    }
    
}
