//
//  Color+Extension.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import SwiftUI

/// Extends String to define color name
public extension String {
    static let popupBackgroundColor = "popupBackgroundColor"
    static let darkBlackColor = "darkBlackColor"
    static let darkModeBgColor = "darkModeBgColor"
}

/// Extends Color to return color from the Assets
public extension Color {
    
    static var popupBackgroundColor: Color {
        return getColor(with: .popupBackgroundColor)
    }
    
    static var darkBlackColor: Color {
        return getColor(with: .darkBlackColor)
    }
    
    static var darkModeBgColor: Color {
        return getColor(with: .darkModeBgColor)
    }
    
    static func rgb(_ r: Double, _ g: Double, _ b: Double, _ a: Double = 1.0) -> Color {
        // return Color(red: r/255.0, green: g/255.0, blue: b/255.0)
        return Color(RGBColorSpace.sRGB, red: r/255.0, green: g/255.0, blue: b/255.0, opacity: a)
    }
    
    static func getColor(with name: String) -> Color {
        if let color = UIColor(named: name) {
            return Color(color)
        } else {
            return .black
        }
    }
}

public extension UIColor {
    
    static var popupBackgroundColor: UIColor {
        return getColor(with: .popupBackgroundColor)
    }
    
    static var darkBlackColor: UIColor {
        return getColor(with: .darkBlackColor)
    }
    
    static var darkModeBgColor: UIColor {
        return getColor(with: .darkModeBgColor)
    }
    
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    static func getColor(with name: String) -> UIColor {
        if let color = UIColor(named: name) {
            return color
        } else {
            return .black
        }
    }
}
