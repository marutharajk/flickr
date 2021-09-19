//
//  Font+Extension.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import SwiftUI

/// Extends String to define font name
private extension String {
    static var sfProTextBold        = "SFProText-Bold"
    static var sfProTextMedium      = "SFProText-Medium"
    static var sfProTextLight       = "SFProText-Light"
    static var sfProTextRegular     = "SFProText-Regular"
    static var sfProTextSemibold    = "SFProText-Semibold"
    static var sfProTextThin        = "SFProText-Thin"
    static var sfProDisplayBold     = "SFProDisplay-Bold"
    static var sfProDisplayMedium   = "SFProDisplay-Medium"
}

// MARK: - Type - Font+Extension -

/// Extends Font to return custom font as Font
public extension Font {
    
    static func sfProTextBold(_ size: CGFloat = 12.0) -> Font {
        return Font.custom(.sfProTextBold, size: size)
    }
    
    static func sfProTextMedium(_ size: CGFloat = 12.0) -> Font {
        return Font.custom(.sfProTextMedium, size: size)
    }
    
    static func sfProTextLight(_ size: CGFloat = 12.0) -> Font {
        return Font.custom(.sfProTextLight, size: size)
    }
    
    static func sfProTextRegular(_ size: CGFloat = 12.0) -> Font {
        return Font.custom(.sfProTextRegular, size: size)
    }
    
    static func sfProTextSemibold(_ size: CGFloat = 12.0) -> Font {
        return Font.custom(.sfProTextSemibold, size: size)
    }
    
    static func sfProDisplayBold(_ size: CGFloat = 12.0) -> Font {
        return Font.custom(.sfProDisplayBold, size: size)
    }
    
    static func sfProDisplayMedium(_ size: CGFloat = 12.0) -> Font {
        return Font.custom(.sfProDisplayMedium, size: size)
    }
    
    static func sfProTextThin(_ size: CGFloat = 12.0) -> Font {
        return Font.custom(.sfProTextThin, size: size)
    }
}

/// Extends UIFont to return custom font as UIFont
public extension UIFont {
    
    static func getFont(name: String, size: CGFloat) -> UIFont {
        return UIFont.init(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func sfProTextBold(_ size: CGFloat = 12.0) -> UIFont {
        return UIFont.init(name: .sfProTextBold, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func sfProTextMedium(_ size: CGFloat = 12.0) -> UIFont {
        return UIFont.init(name: .sfProTextMedium, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func sfProTextLight(_ size: CGFloat = 12.0) -> UIFont {
        return UIFont.init(name: .sfProTextLight, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func sfProTextRegular(_ size: CGFloat = 12.0) -> UIFont {
        return UIFont.init(name: .sfProTextRegular, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func sfProTextSemibold(_ size: CGFloat = 12.0) -> UIFont {
        return UIFont.init(name: .sfProTextSemibold, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func sfProDisplayBold(_ size: CGFloat = 12.0) -> UIFont {
        return UIFont.init(name: .sfProDisplayBold, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func sfProDisplayMedium(_ size: CGFloat = 12.0) -> UIFont {
        return UIFont.init(name: .sfProDisplayMedium, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func sfProTextThin(_ size: CGFloat = 12.0) -> UIFont {
        return UIFont.init(name: .sfProTextThin, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
