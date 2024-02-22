//
//  LibraryViewModel.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import Foundation

@Observable class LibraryViewModel {
    
    var currentPage: Int = .zero
    var error: Error?
    var library: Library?
    var grouped: [String: [Book]] = [:]
    var sections: [String] {
        Array(grouped.keys).sorted()
    }
    
    var topBannerSlides: [Book] = []
    var propositions: [Book] = []
}

extension LibraryViewModel: BaseViewModel {
    func onAppear() {
        guard let jsonFileURL = Bundle.main.url(forResource: "Library", withExtension: "json") else { return }
        
        do {
            let jsonData = try Data(contentsOf: jsonFileURL)
            let library = try JSONDecoder().decode(Library.self, from: jsonData)
            self.library = library
            self.grouped = Dictionary(grouping: library.books ?? [], by: { $0.genre ?? "" })
            let bookIds = library.topBannerSlides?.compactMap{ $0 }.map(\.bookID) ?? []
            let filteredBooks = library.books?.filter { bookIds.contains($0.id) } ?? []
            topBannerSlides = filteredBooks
            
            let propositionsBookIds = library.youWillLikeSection?.compactMap{ $0 } ?? []
            
            self.propositions = library.books?.filter { propositionsBookIds.contains($0.id!) } ?? []

        } catch let error {
            assertionFailure("Wrong JSON format \(error)")
        }
    }
    
    func list(for key: String) -> [Book] {
        grouped[key] ?? []
    }
}
