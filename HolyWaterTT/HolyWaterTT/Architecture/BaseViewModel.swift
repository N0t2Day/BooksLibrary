//
//  BaseViewModel.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import Foundation

protocol BaseViewModel {
    func onAppear()
}

protocol SceneViewModel: BaseViewModel {
    var error: Error? { get set }
}

protocol RowViewModel: BaseViewModel {
    
}
