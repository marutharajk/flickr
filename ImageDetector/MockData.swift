//
//  MockData.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import Foundation

public class MockData {
    
    public init() {}
    
    public static let shared = MockData()
    
    public func jsonData(for fileName: String) -> Data {
        let bundle = Bundle(for: MockData.self)
        let path = bundle.url(forResource: fileName, withExtension: "json")
        let data = try? Data(contentsOf: path!)
        
        return data!
    }
    
    public var isSuccessResponse = true
    public var jsonFileName = String.init()
}
