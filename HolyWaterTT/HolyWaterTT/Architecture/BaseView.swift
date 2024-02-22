//
//  BaseView.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI

protocol BaseView: View {
    associatedtype Content: View
    var content: Content { get }
}

protocol SceneView: BaseView {
    associatedtype ViewModel: BaseViewModel
    var viewModel: ViewModel { get }
}

protocol RowView: BaseView {
    associatedtype ViewModel: RowViewModel
    var viewModel: ViewModel { get }
}

extension BaseView {
    var body: some View {
        content
    }
}
