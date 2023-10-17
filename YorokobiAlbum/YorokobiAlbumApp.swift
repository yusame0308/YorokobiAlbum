//
//  YorokobiAlbumApp.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/03.
//

import SwiftUI
import SwiftData

@main
struct YorokobiAlbumApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Item.self)
    }
}
