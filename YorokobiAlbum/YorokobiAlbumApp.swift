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
            HomeView(imageDatas: [
                UIImage.sample1.pngData()!,
                UIImage.sample2.pngData()!,
                UIImage.sample3.pngData()!,
                UIImage.sample4.pngData()!,
                UIImage.sample5.pngData()!,
                UIImage.sample6.pngData()!
            ])
        }
        .modelContainer(sharedModelContainer)
    }
}
