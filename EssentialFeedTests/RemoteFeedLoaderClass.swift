//
//  RemoteFeedLoaderClass.swift
//  EssentialFeedTests
//
//  Created by Nikhil Gharge on 30/03/22.
//

import XCTest

class RemoteFeedLoader{
    
    let HTTPClient:HTTPClient
    let url: URL
    
    init(withClient: HTTPClient, andURL: URL){
        HTTPClient = withClient
        url = andURL
    }
    func load(){
        HTTPClient.getURL(from:url)
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
        let url = URL(string:"https://www.algoexpert.io/data-structures")!
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(withClient:client, andURL:url)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL(){
        let url = URL(string:"https://www.algoexpert.io/data-structures")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(withClient: client, andURL:url)
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
    
}
