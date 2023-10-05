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

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: Self.itemSpacing) {
                ForEach(imageDatas, id: \.self) { imageData in
                    VStack(spacing: 6) {
                        Image(uiImage: UIImage(data: imageData)!)
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                        Text("あいうえおあいうえおあいうえおあいうえおあいうえおあいうえお")
                            .font(.custom("HiraKakuProN-W3", size: 14))
                            .minimumScaleFactor(0.7)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .kerning(1)
                            .frame(height: 60)
                            .padding(.horizontal, 12)
                    }
                    .padding(.bottom, 6)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal, Self.itemSpacing)
        }
        .background(Color(UIColor.secondarySystemBackground))
    }
}

#Preview {
    let imageDatas: [Data] = [
        UIImage.sample1.pngData()!,
        UIImage.sample2.pngData()!,
        UIImage.sample3.pngData()!,
        UIImage.sample4.pngData()!,
        UIImage.sample5.pngData()!,
        UIImage.sample6.pngData()!,
//        UIImage.sample7.pngData()!,
//        UIImage.sample8.pngData()!,
//        UIImage.sample9.pngData()!,
//        UIImage.sample10.pngData()!
    ]

    return HomeView(imageDatas: imageDatas)
}
