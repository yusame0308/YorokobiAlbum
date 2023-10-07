//
//  RateView.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/06.
//

import SwiftUI

struct RateView: View {
    enum RateViewType {
        case small
        case large
    }

    let rate: Int
    let type: RateViewType

    init(rate: Int, type: RateViewType = .small) {
        self.rate = rate
        self.type = type
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<rate, id: \.self) { _ in
                Image(systemName: "star.fill")
            }
            ForEach(0..<5-rate, id: \.self) { _ in
                Image(systemName: "star")
            }
        }
        .font(.system(size: type == .small ? 10 : 16))
        .foregroundStyle(Color(UIColor.darkGray))
    }
}

#Preview {
    RateView(rate: 3)
}
