//
//  SplashView.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI

struct SplashView: SceneView {
    
    @Environment(MainFlowCoordinator.self) var coordinator
    
    @State var viewModel: SplashViewModel
    
    var content: some View {
        ZStack {
            PlaceholderView()
            VStack(spacing: 12.0) {
                Text("Book App")
                    .font(Fonts.georgiaBoldItalic(size: 52))
                    .foregroundStyle(Colors.pinkMain)
                Text("Welcome to Book App")
                    .font(Fonts.nunitoSansBold(size: 24))
                    .foregroundStyle(Color.white)
                ProgressAnimation()
            }
            .fixedSize(horizontal: true, vertical: false)
        }
        .onAppear {
            viewModel.onAppear()
            Task {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                coordinator.welcomeViewPresented = true
            }
        }
    }
}

#Preview {
    SplashView(viewModel: .init())
        .environmentObject(MainFlowCoordinator())
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
        .previewDisplayName("iPhone 14 Pro Max")
}

#Preview {
    SplashView(viewModel: .init())
        .environmentObject(MainFlowCoordinator())
        .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
        .previewDisplayName("iPhone 14")
}

#Preview {
    SplashView(viewModel: .init())
        .environmentObject(MainFlowCoordinator())
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
        .previewDisplayName("iPhone 14 Pro")
}
