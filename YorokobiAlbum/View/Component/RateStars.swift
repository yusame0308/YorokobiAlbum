//
//  RateStars.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/06.
//

import SwiftUI

struct RateStars: View {
    enum RateViewType {
        case small
        case medium
        case large

        var spacing: CGFloat {
            switch self {
            case .small: 0.0
            case .medium: 2.0
            case .large: 3.0
            }
        }

        var size: CGFloat {
            switch self {
            case .small: 10.0
            case .medium: 18.0
            case .large: 20.0
            }
        }
    }

    let rate: Int
    let type: RateViewType

    init(_ rate: Int, type: RateViewType = .small) {
        self.rate = rate.between(1, 5)
        self.type = type
    }

    var body: some View {
        HStack(spacing: type.spacing) {
            ForEach(0..<rate, id: \.self) { _ in
                Image(systemName: "star.fill")
            }
            ForEach(0..<5-rate, id: \.self) { _ in
                Image(systemName: "star")
            }
        }
        .font(.system(size: type.size))
        .foregroundStyle(Color(UIColor.darkGray))
    }
}

#Preview {
    RateStars(3)
}
