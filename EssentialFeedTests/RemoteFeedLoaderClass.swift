//
//  RemoteFeedLoaderClass.swift
//  EssentialFeedTests
//
//  Created by Nikhil Gharge on 30/03/22.
//

import XCTest
@testable import EssentialFeed

class RemoteFeedLoaderClass: XCTestCase {
    
    // Naming convention for test: test(one we are testing)_nameOfTheTest_behaviourOfTest

    func test_init_testDoesNotRequestDataFromURL(){
        let url = URL(string:"https://www.algoexpert.io/data-structures")!
        let (_, client)  = makeSUT(withURL:url)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestsDataFromURL(){
        let url = URL(string:"https://www.algoexpert.io/data-structures")!
        let (sut, client) = makeSUT(withURL:url)
        sut.load{ error in
            
        }
        XCTAssertNotNil(client.requestedURL)
    }
    
    func test_load_deliversErrorOnClientError(){
        let url = URL(string:"https://www.algoexpert.io/data-structures")!
        let (sut, client) = makeSUT(withURL:url)
        var captureError =  [RemoteFeedLoader.Error]()
        
        sut.load{
            
            captureError.append($0)
            
        }
        
        let clientError = NSError(domain:"Test", code: 0)
        client.complete(withError:clientError)
        
        XCTAssertEqual(captureError, [.connectivity])
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse(){
        let url = URL(string:"https://www.algoexpert.io/data-structures")!
        let (sut, client) = makeSUT(withURL:url)
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            
            var captureError =  [RemoteFeedLoader.Error]()
            
            sut.load{
                
                captureError.append($0)
                
            }
            client.complete(withStatusCode:code, at: index)
            XCTAssertEqual(captureError, [.invalidData])
        }
        
        func test_load_deliversErrorOn200HTTPResponsewithInvalidJSON(){
            let url = URL(string:"https://www.algoexpert.io/data-structures")!
            let (sut, client) = makeSUT(withURL:url)
            
            var capturedError = [RemoteFeedLoader.Error]()
            
            sut.load{
                capturedError.append($0)
            }
            let invalidJSON = Data(bytes:"invalid json".utf8)
            client.complete(withStatusCode:200, data: invalidJSON)
            XCTAssertEqual(capturedError,[.invalidData])
            
        }
    }
    
    // MARK:- Helpers
    
    private func makeSUT(withURL: URL) -> (sut:RemoteFeedLoader, HTTPClient: HTTPClientSpy){
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(withClient: client, andURL:withURL)
        return (sut, client)
    }
    
    class HTTPClientSpy: HTTPClient{
        
        var requestedURL: URL?
        
        private var messages = [(url:URL, completion: (HTTPClientResult) -> Void)]()
        
        func getURL(from url: URL, completionHandeler: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completionHandeler))
            requestedURL = url
        }
        
        func complete(withError error:Error, at index:Int = 0){
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode: Int, data: Data = Data(), at index:Int = 0){
            guard let responseURL = requestedURL else{return}
            let response = HTTPURLResponse(url:responseURL, statusCode:withStatusCode, httpVersion: nil, headerFields: nil)!
            messages[index].completion(.success(data, response))
        }
    }
    
}
