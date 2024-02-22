//
//  LibraryFlowItem.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import Foundation

class LibraryFlowItem: BaseFlowItem { }

class BookFlowItem: BaseFlowItem {
    
    let book: Book
    
    init(book: Book) {
        self.book = book
        super.init(id: "\(book.id ?? .zero)", title: book.name.emptyIfNil)
    }
}
