//
//  NetworkAdapter.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import UIKit

public typealias JSON = [String: Any]

// MARK: - Category -

/// Extends Int to define maximum network request retry count
private extension Int {
    static let maximumRetryCount = 2
}

// MARK: - Type - NetworkAdapter -

/**
 NetworkAdapter will act as Interface between ViewModel and Data Access Layer. It deals the below.
 - Consume search service request
 - Parse server response and store into Model
 */
class NetworkAdapter: NSObject {
    
    let network = NetworkEngine()
    
    /**
     @method - fetch
      - Description: Invoke fetchNetworkPromise to consume network service request
      - Parameters:
        - request: Request Params
        - completion: Return Success with Response Model or Failure with Error Model
      - Returns: Void
     */
    func fetch<T>(modelType: T.Type,
                  request: NetworkRequest,
                  completion: @escaping (NetworkResult<T>) -> Void) where T: Decodable {
        
        fetchNetworkPromise(modelType: modelType, request: request) { (result) in
            completion(result)
        }
    }
    
    /**
     @method - fetchNetworkPromise
      - Description: Invoke NetworkEngine to fetch response for service request &  parse the response and save into Model
      - Parameters:
        - request: Request Params
        - completion: Return Success with Response Model or Failure with Error Model
      - Returns: Void
     */
    func fetchNetworkPromise<T>(modelType: T.Type,
                                request: NetworkRequest,
                                completion: @escaping (NetworkResult<T>) -> Void) where T: Decodable {
        
        network.fetchPromise(.maximumRetryCount, request.buildable) { result in
            self.fetchNetworkPromiseCompletion(modelType: modelType, from: result) { (result) in
                completion(result)
            }
        }
    }
    
    /**
     @method - fetchNetworkPromiseCompletion
      - Description: Network promise completion handler
      - Parameters:
        - data: flickr service request response retrieved from server
        - resource: Request Params and Response Model
        - completion: Return Success with Response Model or Failure with Error Model
      - Returns: Void
     */
    func fetchNetworkPromiseCompletion<T>(modelType: T.Type,
                                          from networkResult: NetworkResult<Data>,
                                          completion: @escaping (NetworkResult<T>) -> Void) where T: Decodable {
        
        switch networkResult {
        
        case .Success:
            do {
                let jsonModel = try JSONDecoder().decode(modelType, from: networkResult.value!)
                completion(.Success(jsonModel))
            } catch {
                completion(NetworkResult.Failure(error))
            }
        case let .Failure(error):
            completion(NetworkResult.Failure(error))
        }
    }
}
