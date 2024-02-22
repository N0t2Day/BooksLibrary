//
//  Fonts.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI

enum Fonts {
    static func georgiaBold(size: CGFloat) -> Font {
        Font.custom("Georgia-Bold", size: size)
    }
    
    static func georgiaBoldItalic(size: CGFloat) -> Font {
        Font.custom("Georgia-BoldItalic", size: size)
    }
    
    static func georgiaItalic(size: CGFloat) -> Font {
        Font.custom("Georgia-Italic", size: size)
    }
    
    static func georgia(size: CGFloat) -> Font {
        Font.custom("Georgia", size: size)
    }
    
    static func nunitoSansBold(size: CGFloat) -> Font {
        Font.custom("NunitoSans-Bold", size: size)
    }
    
    static func nunitoSansSemiBold(size: CGFloat) -> Font {
        Font.custom("NunitoSans-SemiBold", size: size)
    }
    
    static func nunitoSansRegular(size: CGFloat) -> Font {
        Font.custom("NunitoSans-Regular", size: size)
    }
}
