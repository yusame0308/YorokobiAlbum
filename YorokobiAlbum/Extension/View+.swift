//
//  View+.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/13.
//

import SwiftUI

extension View {
    func hiraKakuFont(size: CGFloat, isBold: Bool = false) -> some View {
        self.font(.custom(isBold ? "HiraKakuProN-W6" : "HiraKakuProN-W3", size: size))
    }
}
