//
//  BookDetailViewModel.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 22.02.2024.
//

import Foundation

@Observable class BookDetailViewModel {
    var error: Error?
    var propositions: [Book]
    var selection: Book?
//    private let book: Book
    
    var topItemsPlaceholder: [Book]
    
    init(book: Book, propositions: [Book] = []) {
        self.propositions = propositions
        topItemsPlaceholder = propositions
        topItemsPlaceholder.insert(book, at: 0)
        selection = topItemsPlaceholder.first
    }
}

extension BookDetailViewModel: SceneViewModel {
    func onAppear() {
        
    }
}
