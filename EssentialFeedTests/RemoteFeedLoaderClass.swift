//
//  RemoteFeedLoaderClass.swift
//  EssentialFeedTests
//
//  Created by Nikhil Gharge on 30/03/22.
//

import XCTest

class RemoteFeedLoader{
    func load(){
        HTTPClient.shared.requestedURL = URL(string:"https://www.algoexpert.io/data-structures")
    }
}

class HTTPClient{
    
    static let shared = HTTPClient()
    
    private init(){}
    
    var requestedURL: URL?
}

class RemoteFeedLoaderClass: XCTestCase {

    func test_init_testDoesNotRequestDataFromURL(){
        _ = RemoteFeedLoader()
        let client = HTTPClient.shared
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL(){
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
    
}
