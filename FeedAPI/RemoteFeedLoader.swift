//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Nikhil Gharge on 30/03/22.
//

import Foundation

public enum HTTPClientResult{
    case success(Data,HTTPURLResponse)
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
    
    public enum Result: Equatable{
        case success([FeedItem])
        case failure(Error)
    }
    
    public init(withClient: HTTPClient, andURL: URL){
        HTTPClient = withClient
        url = andURL
    }
    
    public func load(completion: @escaping (Result) -> Void){
        HTTPClient.getURL(from: url) { result in
        switch result{
            case let .success(data, response):
                    do {
                        let items = try FeedsItemMapper.map(data, response)
                                completion(.success(items))
                    } catch {
                        completion(.failure(.invalidData))
                    }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

private class FeedsItemMapper {
    
    private struct Root: Decodable{
        let items: [item]
    }
    
    private struct item:Decodable{
        let id:UUID
        let description: String?
        let location:String?
        let image: URL
        
        var item: FeedItem {
            return FeedItem(id: id, description: description, location: location, imageURL: image)
        }
        
    }
    
    static var OK_200: Int {return 200}
    
    static func map(_ data:Data, _ response:HTTPURLResponse) throws -> [FeedItem]{
        guard response.statusCode == OK_200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.items.map{$0.item}
    }
}

