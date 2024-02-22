//
//  LoopItemRowViewModel.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import Foundation

@Observable class LoopItemRowViewModel {
    
    var imageData: Data?
    
    private var book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    func loadImage() {
        guard let coverURL = book.coverURL, let imageUrl = URL(string: coverURL) else { return }
       
        Task { @MainActor in
            do {
                var urlRequest = URLRequest(url: imageUrl)
                urlRequest.cachePolicy = .returnCacheDataElseLoad
                self.imageData = try await URLSession.shared.data(for: urlRequest).0
            } catch let error {
                assertionFailure("[ERROR:] \(error.localizedDescription)")
            }
        }
    }
}

extension LoopItemRowViewModel: RowViewModel {
    func onAppear() {
        loadImage()
    }
}
