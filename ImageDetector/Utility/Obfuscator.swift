//
//  Obfuscator.swift
//  ImageDetector
//
//  Created by Marutharaj K on 16/09/21.
//

import Foundation

// MARK: - Type - Obfuscator -

/**
 Obfuscator will obfuscate the Flickr search API URL
 */
class Obfuscator {
    
    // MARK: - Private Variables -
    
    /// The salt used to obfuscate and reveal the string.
    private var salt: String
    
    // MARK: - Constructor -
    
    init() {
        self.salt = "\(String(describing: ImageDetectorApp.self))\(String(describing: NSObject.self))"
    }
}

// MARK: - Public Methods -

extension Obfuscator {
    
    /**
     @method - bytesByObfuscatingString
      - Description: This method obfuscates the string passed in using the salt that was used when the Obfuscator was initialized.
      - parameters:
        - string: the string to obfuscate
      - returns: the obfuscated string in a byte array
     */
    func bytesByObfuscatingString(string: String) -> [UInt8] {
        let text = [UInt8](string.utf8)
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        
        var encrypted = [UInt8]()
        
        for t in text.enumerated() {
            encrypted.append(t.element ^ cipher[t.offset % length])
        }
        
        // Need to enable when obfuscate new confidential information
        // Log.i("let key: [UInt8] = \(encrypted)\n")
        
        return encrypted
    }
    
    /**
     @method - reveal
      - Description: This method reveals the original string from the obfuscated byte array passed in. The salt must be the same as the one used to encrypt it in the first place.
      - parameters:
        - key: the byte array to reveal
      - returns: the original string
     */
    func reveal(key: [UInt8]) -> String {
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        
        var decrypted = [UInt8]()
        
        for k in key.enumerated() {
            decrypted.append(k.element ^ cipher[k.offset % length])
        }
        
        return String(bytes: decrypted, encoding: .utf8)!
    }
}
