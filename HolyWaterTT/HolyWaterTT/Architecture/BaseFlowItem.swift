//
//  FlowItem.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import Foundation

protocol FlowItem: Hashable, Identifiable {
    var title: String { get set }
}

class BaseFlowItem: FlowItem {
    let id: String
    var title: String
    
    init(id: String, title: String) {
        self.id = id
        self.title = id
    }
    
    init(title: String) {
        self.id = title
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension BaseFlowItem {
    static func == (lhs: BaseFlowItem, rhs: BaseFlowItem) -> Bool {
        lhs.title == rhs.title
    }
    
//    class func tabs() -> [BaseFlowItem] {
//        [ProjectsFlow(title: "Projects"), LinesFlow(title: "Lines"), ProfileFlow(title: "Profile")]
//    }
}
