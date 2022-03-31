//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Nikhil Gharge on 30/03/22.
//

import Foundation

public enum HTTPClientResult{
    case success(HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient{
    func getURL(from url: URL, completionHandeler: @escaping (HTTPClientResult) -> Void)
}

public class RemoteFeedLoader{
    
    private let url: URL
    private let HTTPClient:HTTPClient
    
    public enum Error: Swift.Error{
        case connectivity
        case invalidData
    }
    
    public init(withClient: HTTPClient, andURL: URL){
        HTTPClient = withClient
        url = andURL
    }
    
    public func load(completion: @escaping (Error) -> Void){
        HTTPClient.getURL(from: url) { result in
        switch result{
            case .success:
                completion(.invalidData)
            case .failure:
                completion(.connectivity)
        }
      }
  }
}

