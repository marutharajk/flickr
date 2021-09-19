//
//  RequestBuilder.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import Foundation

// MARK: - Protocol - RequestBuilder -

/**
 Types adopting the `RequestBuilder` protocol can be used to build dictionary of flickr service request parameters.
*/
public protocol RequestBuilder {
    /// HTTP Method: GET or POST
    var httpMethod: HTTPMethod { get }
    
    /// Recipe service type
    var serviceType: ServiceType { get }

    /// API Path for the request - should not start with "/"
    var path: ServicePath { get }
        
    /// Decision maker to cache the content at CoreData
    var offlineEnabled: Bool { get }
    
    /// Optional - Defaults to .90
    var httpTimeout: HTTPTimeout { get }
    
    var queryParams: String { get }

    /// Optional - Defaults to nil
    var headers: [NetworkConstants.HTTPHeaders: String] { get }
    
    /// Converts properties into key-value parameters
    func paramsDictionary() -> [String: Any]
}

/// Extends RequestBuilder to conform default network service request parameters
public extension RequestBuilder {
    
    var httpMethod: HTTPMethod {
        return .POST
    }
    
    var serviceType: ServiceType {
        return .feeds
    }
    
    var offlineEnabled: Bool {
        return false
    }
    
    var httpTimeout: HTTPTimeout {
        return .ten
    }
    
    var queryParams: String {
        return  .init()
    }
    
    var headers: [NetworkConstants.HTTPHeaders: String] {
        return [:]
    }
    
    func paramsDictionary() -> [String: Any] {
        return [:]
    }
}

/// Extends RequestBuilder to expose methods for build URLRequest
extension RequestBuilder {
    
    /**
     @method - build
      - Description: Builds a  network request
      - Parameters:
        - Void
      - Returns: URLRequest object
    */
    func build() -> URLRequest {
        
        let url = getURL()
        
        Log.i("Service URL: \(url)")
        
        // Building the Request object
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = TimeInterval(httpTimeout.rawValue)
        request.cachePolicy = .useProtocolCachePolicy
        
        headers.keys.forEach { key in
            request.setValue(headers[key], forHTTPHeaderField: key.rawValue)
        }
        
        let jsonDictionary = paramsDictionary()
        if !jsonDictionary.isEmpty {
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary)
            request.httpBody = jsonData
        }
        
        return request
    }
    
    /**
     @method - getURL
      - Description: Builds a  URL
      - Parameters:
        - Void
      - Returns: URLRequest object
    */
    func getURL() -> URL {
        var urlString: String = Obfuscator().reveal(key: AppConfiguration.shared.serviceURL)
        
        urlString += path.rawValue
        
        if !queryParams.isEmpty {
            urlString += queryParams
        }
        
        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? .init()
        
        return URL(string: escapedString)!
    }
}
