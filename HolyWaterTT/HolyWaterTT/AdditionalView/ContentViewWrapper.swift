//
//  ContentViewWrapper.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI

struct ContentViewWrapper<Value: Hashable, Content: View>: View {
    
    @Binding var value: Value?
    let content: ((Value) -> Content)
    
    var body: some View {
        if let value = value {
            content(value)
        } else {
            PlaceholderView()
        }
    }
}
