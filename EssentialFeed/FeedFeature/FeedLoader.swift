//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Nikhil Gharge on 30/03/22.
//

import Foundation

enum LoadFeedResult{
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader{
    func loadFeeds(completion: @escaping (LoadFeedResult) -> Void)
}
