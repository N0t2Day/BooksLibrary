//
//  LoopItemRowView.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI

struct LoopItemRowView: RowView {
    
    @State var viewModel: LoopItemRowViewModel
    
    var content: some View {
        RoundedRectangle(cornerRadius: 16.0, style: .continuous)
            .fill(Colors.grayColor)
            .overlay {
                if let imageData = viewModel.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 16.0))
                        .drawingGroup()
                } else {
                    ProgressView()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    LoopItemRowView(viewModel: .init(book: .mock))
}
