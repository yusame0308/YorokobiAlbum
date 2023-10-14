//
//  HomeView.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    let items: [Item]
    @State private var presentation: Presentation?
    static private let itemSpacing = 12.0
    private let columns = [GridItem(.adaptive(minimum: 160, maximum: 200), spacing: itemSpacing)]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: Self.itemSpacing) {
                    ForEach(items, id: \.self) { item in
                        VStack(spacing: 5) {
                            Image(uiImage: UIImage(data: item.imageData)!)
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                            VStack(spacing: 0) {
                                RateStars(item.rate)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(item.title)
                                    .hiraKakuFont(size: 14)
                                    .minimumScaleFactor(0.7)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(3)
                                    .kerning(1)
                                    .frame(height: 50)
                            }
                            .padding(.horizontal, 12)
                            .padding(.bottom, 10)
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .onTapGesture {
                            presentation = .itemDetail(item)
                        }
                    }
                }
                .padding(.horizontal, Self.itemSpacing)
            }
            .background(Color(UIColor.secondarySystemBackground))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // 並び替え
                    }) {
                        Image(systemName: "arrow.up.and.down.text.horizontal")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        presentation = .addItem
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $presentation) { $0 }
        }
    }
}

extension HomeView {
    private enum Presentation: View, Hashable, Identifiable {
        case addItem
        case itemDetail(_ item: Item)

        var id: Self { self }

        var body: some View {
            switch self {
            case .addItem:
                PhotoSelectView()
            case .itemDetail(let item):
                ItemDetailView(item: item)
            }
        }
    }
}

#Preview {
    let items: [Item] = [
        Item(imageData: UIImage.sample1.pngData()!, title: "title1", rate: 3, createdAt: Date()),
        Item(imageData: UIImage.sample2.pngData()!, title: "title2", rate: 4, createdAt: Date()),
        Item(imageData: UIImage.sample3.pngData()!, title: "title3", rate: 2, createdAt: Date()),
        Item(imageData: UIImage.sample4.pngData()!, title: "title4", rate: 5, createdAt: Date()),
        Item(imageData: UIImage.sample5.pngData()!, title: "title5", rate: 1, createdAt: Date()),
        Item(imageData: UIImage.sample6.pngData()!, title: "title6", rate: 4, createdAt: Date())
    ]

    return HomeView(items: items)
}
