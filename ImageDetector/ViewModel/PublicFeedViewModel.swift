//
//  PublicFeedViewModel.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import Foundation

// MARK: - Type - PublicFeedViewModel -

/**
 PublicFeedViewModel will invoke 'feeds' service
 */
final class PublicFeedViewModel: ObservableObject {
    
    // MARK: - Private Properties -
        
    @Published private(set) var publicFeed: PublicFeed?
    
    private let networkAdapter: NetworkAdapter
    private let tags: String

    // MARK: - Public Properties -
    
    var didReceivedFeeds: ((PublicFeedViewModel, Bool) -> Void)?
    @Published var error: Error?
    
    // MARK: - Constructors -
    
    init(networkAdapter: NetworkAdapter,
         tags: String) {
        self.networkAdapter = networkAdapter
        self.tags = tags
        bindRequestAndResponse()
    }
}

/// Exposed private methods for bind 'feeds' service request and response
private extension PublicFeedViewModel {
    
    /**
     @method - bindRequestAndResponse
     - Description: Bind 'feeds' service request and response
     - Parameters:
     - Void
     - Returns: Void
     */
    private func bindRequestAndResponse() {
        
        let feedsRequest = FeedsRequest(tags)
        let networkRequest = NetworkRequest(with: feedsRequest)
        
        networkAdapter.fetch(modelType: PublicFeed.self,
                             request: networkRequest,
                             completion: { response in
                                switch response {
                                case .Success(let feeds):
                                    self.publicFeed = feeds
                                    self.didReceivedFeeds?(self, true)
                                case .Failure(let error):
                                    self.error = error
                                    self.didReceivedFeeds?(self, false)
                                }
                             })
    }
}
