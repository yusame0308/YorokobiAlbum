//
//  Item.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/05.
//

import Foundation
import UIKit

final class Item {
    private let id: String
    private let imageData: Data
    var title: String
    var rate: Int
    var createdAt: Date

    init(imageData: Data, title: String, rate: Int, createdAt: Date) {
        self.id = UUID().uuidString
        self.imageData = imageData
        self.title = title
        self.rate = rate
        self.createdAt = Date()
    }

    var image: UIImage {
        UIImage(data: imageData) ?? UIImage.noimage
    }
}

extension Item: Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
