//
//  ProgressAnimation.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI

struct ProgressAnimation: View {
    @State private var drawingWidth = false
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(.systemGray))
            RoundedRectangle(cornerRadius: 3)
                .fill(.white)
                .frame(width: drawingWidth ? 250 : 0, alignment: .leading)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false), value: drawingWidth)
        }
        .frame(width: 250, height: 6)
        .onAppear {
            drawingWidth.toggle()
        }
    }
}
#Preview {
    ProgressAnimation()
}
