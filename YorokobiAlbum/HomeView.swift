//
//  HomeView.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    let items = ["1", "2", "3"]

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
        }
    }
}

#Preview {
    HomeView()
}
