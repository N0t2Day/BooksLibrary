//
//  BookRowView.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI

struct BookRowView: RowView {
    
    @State var viewModel: BookRowViewModel
    
    var content: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let imageData = viewModel.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 16.0))
                    .drawingGroup()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                        .fill(Colors.grayColor)
                        .frame(height: 150)
                    ProgressView()
                }
            }
            Text(viewModel.title)
                .lineLimit(2)
                .font(Fonts.nunitoSansSemiBold(size: 16))
                .foregroundStyle(Colors.grayText)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .frame(width: 120)
        .onAppear {
            viewModel.onAppear()
        }
    }
}
