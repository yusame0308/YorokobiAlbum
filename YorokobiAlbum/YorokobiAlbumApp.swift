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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SampleItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView(items: [
                Item(imageData: UIImage.sample1.pngData()!, title: "あいうえおあいうえおあいうえおあいうえおあいうえおあいうえお", rate: 3, createdAt: Date()),
                Item(imageData: UIImage.sample2.pngData()!, title: "あいうえおあいうえお", rate: 4, createdAt: Date()),
                Item(imageData: UIImage.sample3.pngData()!, title: "あいうえおあいうえおあいうえおあいうえお", rate: 2, createdAt: Date()),
                Item(imageData: UIImage.sample4.pngData()!, title: "あいうえおあいうえおあいうえお", rate: 5, createdAt: Date()),
                Item(imageData: UIImage.sample5.pngData()!, title: "あいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえおあいうえお", rate: 1, createdAt: Date()),
                Item(imageData: UIImage.sample6.pngData()!, title: "title6", rate: 4, createdAt: Date())
            ])
        }
        //        .modelContainer(sharedModelContainer)
    }
}
