//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Nikhil Gharge on 30/03/22.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description:String?
    let location:String?
    let imageURL:URL?
}
