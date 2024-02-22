//
//  RootView.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var coordinator: MainFlowCoordinator
    
    var body: some View {
        if coordinator.welcomeViewPresented {
            LibraryView(viewModel: .init())
        } else {
            SplashView(viewModel: .init())
        }
    }
}

#Preview {
    RootView()
}
