//
//  MainFlowCoordinator.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import Foundation

@Observable class MainFlowCoordinator: BaseCoordinator {
    var path: [BaseFlowItem] = []
    var selection: BaseFlowItem?
    
    var welcomeViewPresented: Bool = Bool()
    
    init() {}
}
