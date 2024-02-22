//
//  LibraryView.swift
//  HolyWaterTT
//
//  Created by Artem Kedrov on 21.02.2024.
//

import SwiftUI
import ACarousel

@Observable class InfiniteCarouselItemViewModel {
    
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

extension InfiniteCarouselItemViewModel: RowViewModel {
    func onAppear() {
        loadImage()
    }
}

struct InfiniteCarouselItemView: RowView {
    
    @State var viewModel: InfiniteCarouselItemViewModel
    
    var content: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let imageData = viewModel.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 343, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 16.0))
                    .drawingGroup()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                        .fill(Colors.grayColor)
                        .frame(width: 343, height: 160)
                    ProgressView()
                }
            }
        }
        .frame(width: 120)
        .onAppear {
            viewModel.onAppear()
        }
    }
    

}

struct LibraryView: SceneView {
    
    @EnvironmentObject var coordinator: MainFlowCoordinator
    
    @State var viewModel: LibraryViewModel
    @State var itemIndex: Int = .zero

    var content: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                Colors.almostBlack
                    .ignoresSafeArea()
                VStack {
                    Text("Library")
                        .font(Fonts.nunitoSansBold(size: 20))
                        .foregroundStyle(Colors.pinkMain)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 22)
                        .padding(.horizontal)
                    if viewModel.topBannerSlides.isEmpty == false {
                        ACarousel(viewModel.topBannerSlides, index: $itemIndex, spacing: 16.0, sidesScaling: 1.0, isWrap: true, autoScroll: .active(3)) { item in
                            
                                LoopItemRowView(viewModel: .init(book: item))
                                .onTapGesture {
                                    coordinator.go(to: BookFlowItem(book: item))
                                }
                            
                        }
                        .buttonStyle(.plain)
                        .frame(height: 160)
                        .overlay(alignment: .bottom) {
                            DotsView(dotsCount: viewModel.topBannerSlides.count, currentIndex: $itemIndex)
                                .frame(height: 32)
                        }
                    }
                    List(viewModel.sections, id: \.self) { section in
                        Section {
                            VStack {
                                Text(section)
                                    .font(Fonts.nunitoSansBold(size: 20))
                                    .foregroundStyle(Color.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8.0) {
                                        ForEach(viewModel.list(for: section)) { book in
                                            Button(action: {
                                                coordinator.go(to: BookFlowItem(book: book))
                                            }, label: {
                                                BookRowView(viewModel: .init(book: book))
                                            })
                                        }
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .background(Colors.almostBlack)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listSectionSeparator(.hidden)
                    }
                    .listStyle(.inset)
                    .scrollContentBackground(.hidden)
                    .background(Colors.almostBlack)
                    .padding(.horizontal)

                }
            }
            .navigationDestination(for: BaseFlowItem.self) { item in
                switch item {
                case item as BookFlowItem:
                    BookDetailView(viewModel: .init(book: (item as! BookFlowItem).book, propositions: viewModel.propositions))
                        .toolbar(.hidden, for: .navigationBar)
                default:
                    PlaceholderView()
                }
            }
        }
        
        
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    @ViewBuilder
    func content(for value: BaseFlowItem) -> some View {
        Text("hello")
    }
}

#Preview {
    LibraryView(viewModel: .init())
        .environmentObject(MainFlowCoordinator())
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
        .previewDisplayName("iPhone 14 Pro Max")
}

#Preview {
    LibraryView(viewModel: .init())
        .environmentObject(MainFlowCoordinator())
        .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
        .previewDisplayName("iPhone 14")
}

#Preview {
    LibraryView(viewModel: .init())
        .environmentObject(MainFlowCoordinator())
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
        .previewDisplayName("iPhone 14 Pro")
}
