//
//  UIImage+.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/10.
//

import UIKit

extension UIImage {
    // リサイズして中心を正方形にトリミング
    func cropResizedSquare(offset: CGFloat) -> UIImage {
        let minSideWidth = min(size.width, size.height)
        let resizeWidth = min(minSideWidth, 500.0)
        let resizeRatio = resizeWidth / minSideWidth

        let origin = ratio > 1
        ? CGPoint(x: offset * -resizeRatio, y: 0.0)
        : CGPoint(x: 0.0, y: offset * -resizeRatio)

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: resizeWidth, height: resizeWidth))
        let croppedImage = renderer.image { _ in
            self.draw(in: CGRect(origin: origin, size: CGSize(width: size.width * resizeRatio, height: size.height * resizeRatio)))
        }

        return croppedImage
    }

    var ratio: CGFloat {
        size.width / size.height
    }
}
