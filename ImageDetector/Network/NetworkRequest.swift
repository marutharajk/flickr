//
//  NetworkRequest.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import Foundation

// MARK: - Type - NetworkRequest -

/**
 NetworkRequest will holds the network request params
*/
public struct NetworkRequest {
    
    // MARK: - Properties -
    
    public let buildable: RequestBuilder
    
    // MARK: - Constructors -
    
    public init(with params: RequestBuilder) {
        self.buildable = params
    }
}
