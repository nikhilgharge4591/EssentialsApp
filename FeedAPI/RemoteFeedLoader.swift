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
    
    public init(withClient: HTTPClient, andURL: URL){
        HTTPClient = withClient
        url = andURL
    }
    public func load(){
        HTTPClient.getURL(from:url)
    }
}

public protocol HTTPClient{
    func getURL(from url: URL)
}
