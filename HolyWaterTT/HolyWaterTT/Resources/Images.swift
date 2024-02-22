//
//  Images.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI

enum Images {
    
}

extension Images {
    enum Splash {
        static var background: Image {
            Image("img_splash_background")
        }
        
        static var heart: Image {
            Image("img_heart_background")
        }
    }
    
    enum BookDetail {
        static var arrowLeft: Image {
            Image("arrowLeft")
        }
        
        static var topBackground: Image {
            Image("topBackground")
        }
    }
}
