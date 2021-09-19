//
//  AppConfiguration.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import Foundation

class AppConfiguration: NSObject {
    
    static private(set) var shared = AppConfiguration()
    
    override init() {
        super.init()
    }
    
    var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    /// Service base URL
    var serviceURL: [UInt8] {
        #if DEBUG
        return [33, 25, 21, 23, 22, 126, 74, 91, 4, 19, 29, 65, 20, 45, 25, 19, 37, 33, 97, 1, 5, 8, 76]
        #else
        return .init()
        #endif
    }
    
    /// UI Test Launch Variable
    var isInUITestMode = ProcessInfo.processInfo.environment["isUITest"] != nil
    /// Unit Test Launch Variable
    var isInUnitTestMode = ProcessInfo.processInfo.environment["isUnitTest"] != nil
    
}
