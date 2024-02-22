//
//  BookDetailView.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 22.02.2024.
//

import SwiftUI

struct BookDetailView: SceneView {
    
    @EnvironmentObject var coordinator: MainFlowCoordinator
    
    @State var viewModel: BookDetailViewModel
    @State var currentIndex: Int = .zero
    var content: some View {
        VStack {
            Button(action: {
                coordinator.back()
            }, label: {
                Images.BookDetail.arrowLeft
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            
            SnapCarouselView(currentIndex: $currentIndex, books: viewModel.topItemsPlaceholder)
                .frame(height: 250)
            Text((viewModel.selection?.name).emptyIfNil)
                .font(Fonts.nunitoSansSemiBold(size: 20))
                .foregroundStyle(Color.white)
            Text((viewModel.selection?.author).emptyIfNil)
                .font(Fonts.nunitoSansRegular(size: 14))
                .foregroundStyle(Color.white)
            VStack {
                ScrollView {
                    VStack {
                        HStack {
                            VStack {
                                Text((viewModel.selection?.views).emptyIfNil)                    
                                    .font(Fonts.nunitoSansRegular(size: 18))
                                    .foregroundStyle(Colors.almostBlack)
                                Text("Readers")
                                    .font(Fonts.nunitoSansRegular(size: 12))
                                    .foregroundStyle(Color.gray)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            VStack {
                                Text((viewModel.selection?.likes).emptyIfNil)
                                    .font(Fonts.nunitoSansRegular(size: 18))
                                    .foregroundStyle(Colors.almostBlack)
                                Text("Likes")
                                    .font(Fonts.nunitoSansRegular(size: 12))
                                    .foregroundStyle(Color.gray)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            VStack {
                                Text((viewModel.selection?.quotes).emptyIfNil)
                                    .font(Fonts.nunitoSansRegular(size: 18))
                                    .foregroundStyle(Colors.almostBlack)
                                Text("Quotes")
                                    .font(Fonts.nunitoSansRegular(size: 12))
                                    .foregroundStyle(Color.gray)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            VStack {
                                Text((viewModel.selection?.genre).emptyIfNil)
                                    .font(Fonts.nunitoSansRegular(size: 18))
                                    .foregroundStyle(Colors.almostBlack)
                                Text("Genre")
                                    .font(Fonts.nunitoSansRegular(size: 12))
                                    .foregroundStyle(Color.gray)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                        Divider()
                        Text("Summary")
                            .font(Fonts.nunitoSansRegular(size: 20))
                            .foregroundStyle(Colors.almostBlack)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text((viewModel.selection?.summary).emptyIfNil)
                            .lineLimit(nil)
                            .font(Fonts.nunitoSansRegular(size: 14))
                            .foregroundStyle(Colors.darkGrayText)
                        Divider()
                        
                        if viewModel.propositions.isEmpty == false {
                            Text("You will also like")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(Fonts.nunitoSansRegular(size: 20))
                                .foregroundStyle(Colors.almostBlack)
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(viewModel.propositions) { book in
                                        BookRowView(viewModel: .init(book: book))
                                    }
                                }
                            }
                            .frame(height: 190)
                        }
                    }
                    .padding(.horizontal)
                    .background(Color.white)
                }
                .safeAreaInset(edge: .bottom) {
                    Button {
                        
                    } label: {
                        Text("Read Now")
                            .font(Fonts.nunitoSansRegular(size: 16.0))
                            .foregroundStyle(Color.white)
                    }
                    .frame(height: 48.0)
                    .frame(maxWidth: .infinity)
                    .background(Colors.pinkMain)
                    .clipShape(Capsule())

                    .padding()

                }
            }
            .background(Color.white)
            .cornerRadius(16.0, corners: [.topLeft, .topRight])
        }
        .background(
            Images.BookDetail.topBackground
                .resizable()
                .frame(height: 419)
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
        )
        .onChange(of: currentIndex) { oldValue, newValue in
            viewModel.selection = viewModel.topItemsPlaceholder[newValue]
        }
    }
}


#Preview {
    BookDetailView(viewModel: .init(book: .mock))
        .environmentObject(MainFlowCoordinator())
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
        .previewDisplayName("iPhone 14 Pro Max")
}

#Preview {
    BookDetailView(viewModel: .init(book: .mock))
        .environmentObject(MainFlowCoordinator())
        .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
        .previewDisplayName("iPhone 14")
}

#Preview {
    BookDetailView(viewModel: .init(book: .mock))
        .environmentObject(MainFlowCoordinator())
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
        .previewDisplayName("iPhone 14 Pro")
}

struct SnapCarouselView: View {
    @Binding var currentIndex: Int
    
    let books: [Book]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<books.count, id: \.self) { index in
                    CarouselCardView(book: books[index], bookIndex: index, currentIndex: $currentIndex, geometry: geometry)
                        .offset(x: CGFloat(index - currentIndex) * (geometry.size.width * 0.3) + ((geometry.size.width / 2) - 100))
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let cardWidth = geometry.size.width * 0.3
                        let offset = value.translation.width / cardWidth
                        
                        withAnimation(Animation.spring()) {
                            if value.translation.width < -offset
                            {
                                currentIndex = min(currentIndex + 1, books.count - 1)
                            } else if value.translation.width > offset {
                                currentIndex = max(currentIndex - 1, 0)
                            }
                        }
                        
                    }
            )
        }
    }
}

struct CarouselCardView: View {
    let book: Book
    let bookIndex: Int
    @Binding var currentIndex: Int
    let geometry: GeometryProxy
    
    var body: some View {
        let cardWidth = 200.0
        let cardHeight = 250.0
        let offset = (geometry.size.width - cardWidth) / 2
//        
//        return VStack {
//            RoundedRectangle(cornerRadius: 15)
//                .frame(width: cardWidth, height: cardHeight)
//                .opacity(bookIndex <= currentIndex + 1 ? 1.0 : 0.0)
//                .scaleEffect(bookIndex == currentIndex ? 1.0 : 0.9)
//        }
//        .frame(width: cardWidth, height: cardHeight)
        return LoopItemRowView(viewModel: .init(book: book))
            .frame(width: cardWidth, height: cardHeight)
            .opacity(bookIndex <= currentIndex + 1 ? 1.0 : 0.0)
            .scaleEffect(bookIndex == currentIndex ? 1.0 : 0.9)
            .offset(x: CGFloat(bookIndex - currentIndex) * offset)

    }
}
