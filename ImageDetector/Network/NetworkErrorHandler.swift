//
//  NetworkErrorHandler.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import Foundation

// MARK: - NetworkErrorHandler -

/**
 NetworkErrorHandler will find the error for HTTP connection.
*/
struct NetworkErrorHandler {
    
    /**
     @method - errorCode
      - Description: Get error code from Server Response or Error
      - Parameters:
        - urlResponse: Received Server Response
        - error: Received Server Error
      - Returns: Network Error
     */
    static func errorCode(urlResponse: URLResponse?, error: Error?) -> NetworkError? {
        if let error = error as NSError?, error.code == NSURLErrorCancelled {
            return NetworkError.requestCancelled
        }
        
        if let errorCode = connectionErrorCode(error) {
            return errorCode
        }
        
        return httpErrorCode(urlResponse)
    }
}

// MARK: - Private Methods -

fileprivate extension NetworkErrorHandler {
    
    /**
     @method - connectionErrorCode
      - Description: Get service communication error code from error
      - Parameters:
        - error: Received Server Error
      - Returns: Network Error
     */
    static func connectionErrorCode(_ error: Error?) -> NetworkError? {
        guard let error = error else {
            return nil
        }
        
        var customError: NetworkError?
        
        switch error._code {
        case NSURLErrorTimedOut:
            customError = .networkTimeOut
        case NSURLErrorNotConnectedToInternet:
            customError = .noConnection
        case NSURLErrorUserAuthenticationRequired:
            customError = .unAuthorized
        default:
            customError = .serviceFailure(NetworkConstants.HTTPErrorCodes(rawValue: error._code))
        }
        
        return customError
    }
    
    /**
     @method - httpErrorCode
      - Description: Get HTTP error code from response
      - Parameters:
        - response: Received Server Response
      - Returns: Network Error
     */
    static func httpErrorCode(_ response: URLResponse?) -> NetworkError? {
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return NetworkError.serviceFailure(nil)
        }
        
        // Success Code
        if statusCode == 200 {
            return nil
        }
        
        // Checking for unhandled error codes
        guard let httpErrorCode = NetworkConstants.HTTPErrorCodes(rawValue: statusCode) else {
            return .serviceFailure(nil)
        }
        
        // Handling different error codes
        switch httpErrorCode {
        case .unAuthorized:
            return .unAuthorized
            
        case .notFound, .internalServerError, .serviceUnavailable:
            return .serviceFailure(httpErrorCode)
            
        case .notAcceptable:
            return .notAcceptable
            
        case .badRequest:
            return .badRequest
        
        case .noContent:
            return .noContent
        }
    }
}
