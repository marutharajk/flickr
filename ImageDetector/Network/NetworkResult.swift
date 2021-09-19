//
//  NetworkResult.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import Foundation

// MARK: - Type - NetworkResult -

/**
 NetworkResult will return the JSON response that NetworkAdapter pass the value to ViewModel.
*/
public enum NetworkResult<T> {
    case Success(T)
    case Failure(Error)
    
    // f is a function that when proccessed returns another Result<> enum
    public func flatMap<U>(_ f: (T) -> NetworkResult<U>) -> NetworkResult<U> {
        switch self {
        case .Success(let value):
            return f(value)
        case .Failure(let error):
            return .Failure(error)
        }
    }
    
    /// Return content or user profile service request is success or failure
    public var isSuccess: Bool {
        switch self {
        case .Success:
            return true
        case .Failure:
            return false
        }
    }
    
    /// Return response of the content/user profile service request  or failure
    public var value: T? {
        switch self {
        case .Success(let value):
            return value
        case .Failure:
            return nil
        }
    }
}
