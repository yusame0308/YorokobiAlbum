//
//  Item.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/05.
//

import Foundation

final class Item {
    var imageData: Data
    var comment: String
    var rate: Int
    var createdAt: Date

    init(imageData: Data, comment: String, rate: Int, createdAt: Date) {
        self.imageData = imageData
        self.comment = comment
        self.rate = rate
        self.createdAt = Date()
    }
}
