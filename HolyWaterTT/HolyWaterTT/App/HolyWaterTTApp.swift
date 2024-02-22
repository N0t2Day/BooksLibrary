//
//  HolyWaterTTApp.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI

@main
struct HolyWaterTTApp: App {
    
    @State var coordinator: MainFlowCoordinator = .init()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(coordinator)
        }
    }
}
