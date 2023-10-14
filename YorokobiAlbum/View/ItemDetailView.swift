//
//  ItemDetailView.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/14.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item

    var body: some View {
        Text(item.title)
    }
}

#Preview {
    ItemDetailView(item: Item(imageData: Data(), title: "title", rate: 3, createdAt: Date()))
}
