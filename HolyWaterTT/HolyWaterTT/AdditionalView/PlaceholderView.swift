//
//  PlaceholderView.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        ZStack {
            Images.Splash.background
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            Images.Splash.heart
                .resizable()
                .scaledToFill()
        }
    }
}
