//
//  Item.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/03.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
