//
//  RemoteFeedLoaderClass.swift
//  EssentialFeedTests
//
//  Created by Nikhil Gharge on 30/03/22.
//

import XCTest

class RemoteFeedLoader{
    func load(){
        HTTPClient.shared.getURL(from:URL(string:"https://www.algoexpert.io/data-structures")!)
    }
}

class HTTPClient{
    
    static var shared = HTTPClient()
    
    func getURL(from url: URL) {}
    
}

class HTTPClientSpy: HTTPClient{
    
    override func getURL(from url: URL){
        requestedURL = url
    }
    
    var requestedURL: URL?
    
}

class RemoteFeedLoaderClass: XCTestCase {

    func test_init_testDoesNotRequestDataFromURL(){
        _ = RemoteFeedLoader()
        let client = HTTPClientSpy()
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL(){
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
    
}
