//
//  Int+.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/14.
//

extension Int {
    func between(_ min: Int, _ max: Int) -> Int {
        Swift.max(Swift.min(self, max), min)
    }
}
