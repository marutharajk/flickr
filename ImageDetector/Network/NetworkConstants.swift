//
//  NetworkConstants.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import Foundation

// MARK: - Enum -

/// Service request type
public enum ServiceType: Int {
    case feeds
}

/// Service request path
public enum ServicePath: String {
    case feeds = "services/feeds/photos_public.gne"
}

/// HTTP Method Type
public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
}

/// Service Request Timeout
public enum HTTPTimeout: Int {
    case ten        = 10
    case fifteen    = 15
    case thirty     = 30
    case thirtyfive = 35
    case forty      = 40
    case fortyfive  = 45
    case fifty      = 50
    case fiftyfive  = 55
    case sixty      = 60
    case ninety     = 90 // default
}

// MARK: - Type - NetworkConstants -

/**
 NetworkConstants will configure the
  - List of services
  - HTTP Method and Timeout
  - HTTP Headeres and Error Codes
*/
public struct NetworkConstants {
    
    /// HTTP Header Key
    public enum HTTPHeaders: String {
        case accept
        case contentType    = "Content-Type"
        case authorization  = "Authorization"
        case context        = "X-Client-Context"
        case content        = "X-Client-Content"
    }
    
    /// Create Account and Login Key
    public enum GrantTypes: String {
        case password
        case new
    }
    
    /// HTTP Header Value
    public enum ContentTypes: String {
        case json        = "application/json"
        case urlEncoded  = "application/x-www-form-urlencoded"
    }
    
    /// HTTP Error codes
    public enum HTTPErrorCodes: Int {
        case noContent              = 204
        case badRequest             = 400
        case unAuthorized           = 401
        case notFound               = 404
        case notAcceptable          = 406
        case internalServerError    = 500
        case serviceUnavailable     = 503
        
        init?(with response: URLResponse?) {
            guard
                let httpResponse = response as? HTTPURLResponse,
                let code = HTTPErrorCodes(rawValue: httpResponse.statusCode)
            else {
                return nil
            }
            
            self = code
        }
    }
}
