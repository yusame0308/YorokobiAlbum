//
//  HomeView.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    let imageDatas: [Data]
    static let itemSpacing = 12.0
    let columns = [GridItem(.adaptive(minimum: 160, maximum: 200), spacing: itemSpacing)]
    @State var showingAddView = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: Self.itemSpacing) {
                    ForEach(imageDatas, id: \.self) { imageData in
                        VStack(spacing: 5) {
                            Image(uiImage: UIImage(data: imageData)!)
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                            VStack(spacing: 0) {
                                RateStars(8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("あいうえおあいうえおあいうえおあいうえおあいうえおあいうえお")
                                    .font(.custom("HiraKakuProN-W3", size: 14))
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
                        showingAddView = true
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                PhotoSelectView()
            }
        }
    }
}

#Preview {
    let imageDatas: [Data] = [
        UIImage.sample1.pngData()!,
        UIImage.sample2.pngData()!,
//        UIImage.sample3.pngData()!,
//        UIImage.sample4.pngData()!,
//        UIImage.sample5.pngData()!,
//        UIImage.sample6.pngData()!,
//        UIImage.sample7.pngData()!,
//        UIImage.sample8.pngData()!,
//        UIImage.sample9.pngData()!,
//        UIImage.sample10.pngData()!
    ]

    return HomeView(imageDatas: imageDatas)
}
