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



class RemoteFeedLoaderClass: XCTestCase {

    func test_init_testDoesNotRequestDataFromURL(){
        let url = URL(string:"https://www.algoexpert.io/data-structures")!
        let (_, client)  = makeSUT(withURL:url)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL(){
        let url = URL(string:"https://www.algoexpert.io/data-structures")!
        let (sut, client) = makeSUT(withURL:url)
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
    
    
    // MARK:- Helpers
    
    private func makeSUT(withURL: URL) -> (sut:RemoteFeedLoader, HTTPClient: HTTPClientSpy){
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(withClient: client, andURL:withURL)
        return (sut, client)
    }
    
    class HTTPClientSpy: HTTPClient{
        
        var requestedURL: URL?
        
        func getURL(from url: URL){
            requestedURL = url
        }
        
        
    }
    
}
