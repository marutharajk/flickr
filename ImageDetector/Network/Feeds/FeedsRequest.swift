//
//  FeedsRequest.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import Foundation

// MARK: - Type - FeedsRequest -

/**
 FeedsRequest will configure the feeds request parameter to build the URLRequest
  - Query Parameter: tags - Entered by user on the ImageSearchView
 */
struct FeedsRequest {
    var tags: String
    
    init(_ tags: String) {
        self.tags = tags
    }
}

/// Extends FeedsRequest to conforms RequestBuilder and configure feeds service params
extension FeedsRequest: RequestBuilder {
    
    var httpMethod: HTTPMethod {
        return .GET
    }
    
    var serviceType: ServiceType {
        return .feeds
    }
    
    var path: ServicePath {
        return .feeds
    }
    
    var queryParams: String {
        return "?format=json&nojsoncallback=1&tags=\(tags)"
    }
    
    var headers: [NetworkConstants.HTTPHeaders: String] {
        return [.contentType: NetworkConstants.ContentTypes.json.rawValue]
    }
}
