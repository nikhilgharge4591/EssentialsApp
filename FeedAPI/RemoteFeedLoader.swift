//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Nikhil Gharge on 30/03/22.
//

import Foundation

public class RemoteFeedLoader{
    
    private let url: URL
    private let HTTPClient:HTTPClient
    
    public enum Error: Swift.Error{
        case connectivity
    }
    
    public init(withClient: HTTPClient, andURL: URL){
        HTTPClient = withClient
        url = andURL
    }
    
    public func load(completion: @escaping (Error) -> Void){
        HTTPClient.getURL(from: url) { err in
            completion(Error.connectivity)
        }
    }
}

public protocol HTTPClient{
    func getURL(from url: URL, completionHandeler: (Error) -> Void)
}
