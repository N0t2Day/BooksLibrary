//
//  Library.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import Foundation

// MARK: - Library
struct Library: Codable {
    let books: [Book]?
    let topBannerSlides: [TopBannerSlide]?
    let youWillLikeSection: [Int]?

    enum CodingKeys: String, CodingKey {
        case books
        case topBannerSlides = "top_banner_slides"
        case youWillLikeSection = "you_will_like_section"
    }
}

// MARK: - Book
struct Book: Codable, Identifiable {
    var id: Int?
    let name, author, summary, genre: String?
    let coverURL: String?
    let views, likes, quotes: String?

    enum CodingKeys: String, CodingKey {
        case id, name, author, summary, genre
        case coverURL = "cover_url"
        case views, likes, quotes
    }
}

extension Book: Equatable {
    
}

// MARK: - TopBannerSlide
struct TopBannerSlide: Codable, Identifiable {
    let id, bookID: Int?
    let cover: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bookID = "book_id"
        case cover
    }
}


extension Book {
    static var mock = Book(id: 0, name: "The Sandman", author: "Neil Gaiman", summary: "Neil Gaiman's The Sandman was launched in 1989. This extremely popular series was bound into ten collections. Following Dream of the Endless, also known as Morpheus, Onieros and many other names, we explore a magical world filled with stories both horrific and beautiful.", genre: "Fantasy", coverURL: "https://firebasestorage.googleapis.com/v0/b/bookapp-b1f1b.appspot.com/o/the_sandman.jpg?alt=media&token=db0c3806-da65-4d96-ba4c-f6cf27a92cd3", views: "400K", likes: "30K", quotes: "20K")
}
