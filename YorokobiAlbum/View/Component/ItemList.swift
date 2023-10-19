//
//  ItemList.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/19.
//

import SwiftUI
import SwiftData

struct ItemList: View {
    @Query private var items: [Item]
    @Binding private var presentation: HomeView.Presentation?

    init(sort: [SortDescriptor<Item>], presentation: Binding<HomeView.Presentation?>) {
        _items = Query(sort: sort)
        self._presentation = presentation
    }

    var body: some View {
        ForEach(items) { item in
            VStack(spacing: 5) {
                Image(uiImage: item.image)
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
}
