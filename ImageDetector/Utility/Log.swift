//
//  Log.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import Foundation

// MARK: - Category -

/// Extends string to define log date format
private extension String {
    static let logDateFormat = "yyyy-MM-dd hh:mm:ssSSS"
}

/// Extends Date to return date as string by given format
private extension Date {
    
    /**
     @method -toStringByTimeZone
      - Description: Return date as string for the current timezone by given format
      - Parameters:
        - format: Format of the Date
      - Returns: Date String
    */
    func toStringByTimeZone(_ format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        
        let dateString = dateFormatter.string(from: self)
        
        return dateString
    }
}

/// Enum which maps an appropiate symbol which added as prefix for each log message
///
/// - error: Log type error
/// - info: Log type info
/// - debug: Log type debug
/// - verbose: Log type verbose
/// - warning: Log type warning
/// - severe: Log type severe
enum LogEvent: String {
   case e = "[‼️]" // error
   case i = "[ℹ️]" // info
   case d = "[💬]" // debug
   case v = "[🔬]" // verbose
   case w = "[⚠️]" // warning
   case s = "[🔥]" // severe
}

func print(_ object: Any) {
    // Only allowing in DEBUG mode
    #if DEBUG
    Swift.print(object)
    #endif
}

// MARK: - Type - Log -

/**
  Log will print the error events which will help developer to find the bug during the development.
 */
class Log {
    
    // MARK: - Loging methods
    
    /// Logs error messages on console with prefix [‼️]
    ///   (i.e) 2020-03-01 07:22:56307 [‼️][AppDelegate.swift]:58 15 application(_:didFinishLaunchingWithOptions:) -> Error Log
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func e( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if AppConfiguration.shared.isDebug {
            print("\(Date().toStringByTimeZone(.logDateFormat)) \(LogEvent.e.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    
    /// Logs info messages on console with prefix [ℹ️]
    ///   (i.e) 2020-03-01 07:22:56307 [ℹ️][AppDelegate.swift]:58 15 application(_:didFinishLaunchingWithOptions:) -> Information Log
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func i ( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if AppConfiguration.shared.isDebug {
            print("\(Date().toStringByTimeZone(.logDateFormat)) \(LogEvent.i.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    
    /// Logs debug messages on console with prefix [💬]
    ///  (i.e) 2020-03-01 07:24:31913 [💬][AppDelegate.swift]:58 15 application(_:didFinishLaunchingWithOptions:) -> Debug Log
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func d( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if AppConfiguration.shared.isDebug {
            print("\(Date().toStringByTimeZone(.logDateFormat)) \(LogEvent.d.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    
    /// Logs messages verbosely on console with prefix [🔬]
    ///  (i.e) 2020-03-01 07:26:00046 [🔬][AppDelegate.swift]:58 15 application(_:didFinishLaunchingWithOptions:) -> Verbose Log
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func v( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if AppConfiguration.shared.isDebug {
            print("\(Date().toStringByTimeZone(.logDateFormat)) \(LogEvent.v.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    
    /// Logs warnings verbosely on console with prefix [⚠️]
    ///  (i.e) 2020-03-01 07:26:55165 [⚠️][AppDelegate.swift]:58 15 application(_:didFinishLaunchingWithOptions:) -> Warning Log
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func w( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if AppConfiguration.shared.isDebug {
            print("\(Date().toStringByTimeZone(.logDateFormat)) \(LogEvent.w.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    
    /// Logs severe events on console with prefix [🔥]
    ///   (i.e) 2020-03-01 07:27:58169 [🔥][AppDelegate.swift]:58 15 application(_:didFinishLaunchingWithOptions:) -> Severe Log
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func s( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if AppConfiguration.shared.isDebug {
            print("\(Date().toStringByTimeZone(.logDateFormat)) \(LogEvent.s.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    
    /// Extract the file name from the file path
    ///
    /// - Parameter filePath: Full file path in bundle
    /// - Returns: File Name with extension
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? .init() : components.last!
    }
}
