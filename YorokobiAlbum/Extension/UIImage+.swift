//
//  UIImage+.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/10.
//

import UIKit

extension UIImage {
    // リサイズして中心を正方形にトリミング
    func cropResizedSquare() -> UIImage? {
        let minSideWidth = min(size.width, size.height)
        let resizeWidth = min(minSideWidth, 1000.0)
        let ratio = resizeWidth / minSideWidth

        let origin = size.width > size.height
        ? CGPoint(x: (size.width - minSideWidth) * 0.5 * -ratio, y: 0.0)
        : CGPoint(x: 0.0, y: (size.height - minSideWidth) * 0.5 * -ratio)

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: resizeWidth, height: resizeWidth))
        let croppedImage = renderer.image { c in
            self.draw(in: CGRect(origin: origin, size: CGSize(width: size.width * ratio, height: size.height * ratio)))
        }

        return croppedImage
    }

    var ratio: CGFloat {
        size.width / size.height
    }
}
