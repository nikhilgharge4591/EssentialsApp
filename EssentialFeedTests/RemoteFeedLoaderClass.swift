//
//  RemoteFeedLoaderClass.swift
//  EssentialFeedTests
//
//  Created by Nikhil Gharge on 30/03/22.
//

import XCTest

class RemoteFeedLoader{
    
    let HTTPClient:HTTPClient
    
    init(withClient: HTTPClient){
        HTTPClient = withClient
    }
    func load(){
        HTTPClient.getURL(from:URL(string:"https://www.algoexpert.io/data-structures")!)
    }
}

protocol HTTPClient{
    func getURL(from url: URL)
}

class HTTPClientSpy: HTTPClient{
    
    func getURL(from url: URL){
        requestedURL = url
    }
    
    var requestedURL: URL?
    
}

class RemoteFeedLoaderClass: XCTestCase {

    func test_init_testDoesNotRequestDataFromURL(){
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(withClient:client)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL(){
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(withClient: client)
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
    
}
