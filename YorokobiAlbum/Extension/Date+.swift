//
//  Date+.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/05.
//

import Foundation

extension Date {
    var displayText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "en_US_POSIX")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self)
    }
}
