//
//  DINFont.swift
//  AthleteMinder
//
//  Created by Himan Dhawan on 15/09/21.
//

import Foundation

enum DINFont : String {
    case black = "Black"
    case blackCondensed = "BlackCondensed"
    case blackItalic = "BlackItalic"
    case bold = "Bold"
    case boldCondensed = "BoldCondensed"
    case boldItalic = "BoldItalic"
    case condensed = "Condensed"
    case heavy = "Heavy"
    case heavyCondensed = "HeavyCondensed"
    case heavyItalic = "HeavyItalic"
    case italic = "Italic"
    case light = "Light"
    case lightCondensed = "LightCondensed"
    case lightItalic = "LightItalic"
    case medium = "Medium"
    case mediumCondensed = "MediumCond"
    case mediumItalic = "MediumItalic"
    case regular = "Regular"
    case ultraLight = "UltraLight"
    case ultraLightCondensed = "UltraLightCond"
    case ultraLightCondensedIT = "UltraLightIt"
}

extension DINFont {
    var familyName : String {
        return "DINNextLTPro"
    }
    
    func getFontString() -> String {
        familyName + "-" + self.rawValue
    }
    
}
