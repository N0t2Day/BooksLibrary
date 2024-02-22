//
//  Coordinator.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import Foundation

protocol BaseCoordinator: AnyObject, ObservableObject {
    associatedtype FlowItem: Hashable
    
    var path: [FlowItem] { get set }
    
    func go(to flow: FlowItem)
    
    func back(to flow: FlowItem)
    
    func back()
    
    func toRoot()
}

extension BaseCoordinator {
    func go(to flow: FlowItem) {
        path.append(flow)
    }
    
    func back(to flow: FlowItem) {
        var lastItem = path.removeLast()
        while lastItem != flow {
            lastItem = path.removeLast()
        }
    }
    
    func back() {
        path.removeLast()
    }
    
    func toRoot() {
        path.removeAll()
    }
}

