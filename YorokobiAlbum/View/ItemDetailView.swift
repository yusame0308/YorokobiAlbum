//
//  ItemDetailView.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/14.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let item: Item

    var body: some View {
        VStack(spacing: 12) {
            Image(uiImage: item.image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .layoutPriority(1)
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(item.createdAt.displayText)
                        .font(.subheadline)
                    RateStars(item.rate, type: .large)
                }
                Spacer()
                Button(action: {
                    // TODO: ダイアログ表示
                    modelContext.delete(item)
                    dismiss()
                }, label: {
                    Image(systemName: "trash.circle")
                        .font(.system(size: 24))
                        .foregroundStyle(Color(UIColor.darkGray))
                })
            }
            .padding(.horizontal, 18)
            Text(item.title)
                .frame(maxHeight: .infinity, alignment: .center)
                .foregroundStyle(Color(UIColor.darkGray))
                .hiraKakuFont(size: 20, isBold: true)
                .multilineTextAlignment(.center)
                .kerning(4)
                .lineSpacing(8)
                .padding(.horizontal, 48)
        }
        .padding(.bottom, 48)
    }
}

//#Preview {
//    ItemDetailView(item: Item(imageData: UIImage.sample1.pngData()!, title: "title", rate: 3, createdAt: Date()))
//}
