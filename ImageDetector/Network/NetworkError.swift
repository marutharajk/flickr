//
//  NetworkError.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import Foundation

// MARK: - Type - NetworkError -

/**
 NetworkError will configure list of HTTP and JSON error for showing the appropriate error message to user.
*/
public enum NetworkError: Error {
    
    case noContent
    case badRequest
    case unAuthorized
    case emptyData
    case requestCancelled
    case notAcceptable
    case noConnection
    case offlineMode
    case networkTimeOut
    case parsingFailure
    case serviceFailure(NetworkConstants.HTTPErrorCodes?)
    case unexpectedError
    case general(cause: String)
    
    init(_ cause: String) {
        self = NetworkError.general(cause: cause)
    }

    public var string: String {
        switch self {
        case .noContent:
            return NetworkErrorCodes.unExpectedError
        case .badRequest:
            return NetworkErrorCodes.badRequest
        case .unAuthorized:
            return NetworkErrorCodes.unAuthorized
        case .emptyData:
            return NetworkErrorCodes.unExpectedError
        case .requestCancelled:
            return NetworkErrorCodes.requestCancelled
        case .notAcceptable:
            return NetworkErrorCodes.notAcceptable
        case .noConnection:
            return NetworkErrorCodes.noConnection
        case .offlineMode:
            return NetworkErrorCodes.offlineMode
        case .networkTimeOut:
            return NetworkErrorCodes.timeOut
        case .parsingFailure, .serviceFailure:
            return NetworkErrorCodes.serviceFailure
        case .unexpectedError:
            return NetworkErrorCodes.unExpectedError
        case .general(let cause):
            return cause
        }
    }
}

// MARK: - Category -

/// Extends error to return error message for JSON and Network error
public extension Error {
    
    var string: String {
        switch self {
        case let error as NetworkError:
            return error.string
        case let error as JSONError:
            return error.string
        case let error as JSONContentError:
            return error.string
        default:
            return localizedDescription
        }
    }
}

// MARK: - JSON Error -

public enum JSONError: Error {
    case incorrect
    
    public var string: String {
        return NetworkErrorCodes.unExpectedError
    }
}

// MARK: - JSON Content Error -

public enum JSONContentError: Error {
    case Failure
    case General(cause: String)
    
    public init(_ cause: String) {
        self = JSONContentError.General(cause: cause)
    }
    
    public var string: String {
        var errorMsg: String =  .init()
        
        switch self {
        case .Failure:
            errorMsg = NetworkErrorCodes.failure
        case .General(let cause):
            errorMsg = cause
        }
        
        return errorMsg
    }
}

// MARK: - Network Error Codes -

struct NetworkErrorCodes {

    static let badRequest       = "Invalid syntax"
    static let unAuthorized     = "Unauthorized"
    static let requestCancelled = "Request is cancelled"
    static let notAcceptable    = "Content Error"
    static let noConnection     = "Device is offline"
    static let offlineMode      = "Device is offline"
    static let timeOut          = "Request timeout"
    static let serviceFailure   = "Service Failure"
    static let unExpectedError  = "Unexpected Error"
    static let failure          = "Unexpected Error"
}
