//
//  PublicFeed.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import Foundation

// MARK: - Type - PublicFeedItems -
/**
 PublicFeedItems will holds list of public content matching some criteria.
 */
public struct PublicFeedItems: Codable, Identifiable {
    
    /// Private properties to store public feed item values
    public let id = UUID()
    public var title: String?
    public var link: String?
    public var media: [String: String]?
    public var date_taken: String?
    public var description: String?
    public var published: String?
    public var author: String?
    public var authorId: String?
    public var tags: String?

    /// public feed item keys for decoding.
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case date_taken
        case description
        case published
        case author
        case authorId = "author_id"
        case tags

    }
}

// MARK: - Type - PublicFeed -
/**
 PublicFeed will holds list of recent uploads matching some criteria..
 */
public struct PublicFeed: Codable {
    
    /// Private properties to store recent uploads values
    public var title: String?
    public var link: String?
    public var description: String?
    public var modified: String?
    public var generator: String?
    public var items: [PublicFeedItems]?

    /// Recent uploads keys for decoding.
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case description
        case modified
        case generator
        case items
    }
}
