//
//  SelectableRateStars.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/14.
//

import SwiftUI

struct SelectableRateStars: View {
    @Binding var rate: Int
    @State var initialRate: Int
    let contentInset: EdgeInsets

    init(_ rate: Binding<Int>, contentInset: EdgeInsets) {
        self._rate = rate
        self.initialRate = rate.wrappedValue
        self.contentInset = contentInset
    }

    var body: some View {
        RateStars(rate, type: .medium)
            .padding(contentInset)
            .background(Color.white)
            .gesture(dragGesture)
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let rateOffset = Int(value.translation.width / 15)
                rate = initialRate + rateOffset
            }
            .onEnded { value in
                initialRate = rate.between(1, 5)
            }
    }
}

//#Preview {
//    @State var rate = 3
//    return SelectableRateStars(rate: $rate)
//}
