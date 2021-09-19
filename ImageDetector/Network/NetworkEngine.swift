//
//  NetworkEngine.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import Foundation

// MARK: - Type Alias -

public typealias ResultCompletionDataArrays = (NetworkResult<[Data]>) -> Void
public typealias ResultCompletionData = (NetworkResult<Data>) -> Void

// MARK: - Type - NetworkEngine -

/**
 NetworkEngine is the data access layer of the image detector application. It will communicate with flickr service to retrieve data
*/
final class NetworkEngine: NSObject, URLSessionDelegate {
    
    var currentTask: URLSessionDataTask?

    /**
     @method - fetchPromise
      - Description: Invoke flickr service service
      - Parameters:
        - retryCount: Retry cycle index
        - resource: Request Params with HTTP Method(GET/POST), Body(POST) and Query Parameter(GET)
        - completion: Return success with data or failure with error
      - Returns: Void
    */
    func fetchPromise(_ retryCount: Int, _ resource: RequestBuilder, completion: @escaping ResultCompletionData) {
        
        guard !AppConfiguration.shared.isInUnitTestMode else {
            let data = MockData.shared.jsonData(for: MockData.shared.jsonFileName)
            if MockData.shared.isSuccessResponse {
                completion(.Success(data))
            } else {
                completion(.Failure(NetworkError.emptyData))
            }
            return
        }
        
        if resource.serviceType == .feeds {
            currentTask?.cancel()
        }

        let request = resource.build()
                

        let urlSession = URLSession(configuration: .default)

        currentTask = urlSession.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, response, error) -> Void in
            
            // Check for other errors
            var responseError: Error!
            if let error = self?.errorFor(urlResponse: response, error: error) {
                responseError = error
            }
            
            if let data = data {
                let serverResponse = String(decoding: data, as: UTF8.self)
                Log.i(serverResponse)
                
                completion(.Success(data))
                return
            } else {
                responseError = NetworkError.emptyData
            }
            
            if retryCount > 1 {
                self?.fetchPromise(retryCount - 1, resource, completion: completion)
            } else {
                completion(.Failure(responseError))
                return
            }

        })

        guard let currentTask = currentTask else {
            return
        }
        
        currentTask.resume()
    }
}

// MARK: - Private Methods -

fileprivate extension NetworkEngine {
    
    /**
     @method - errorFor
      - Description: Parse error from the URLResponse
      - Parameters:
        - response: Response for url request
        - error: Error for url request
      - Returns: Network Error
    */
    func errorFor(urlResponse response: URLResponse?, error: Error?) -> NetworkError? {
           
        if let error = NetworkErrorHandler.errorCode(urlResponse: response, error: error) {
            guard NetworkConstants.HTTPErrorCodes(with: response) != nil else {
                return NetworkError.serviceFailure(nil)
            }
            
            return error
            
        } else {
            return nil
        }
    }
}
