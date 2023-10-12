//
//  ItemFormView.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/09.
//

import SwiftUI

struct ItemFormView: View {
    private let dismiss: DismissAction
    private let image: UIImage

    init(dismiss: DismissAction, image: UIImage) {
        self.dismiss = dismiss
        self.image = image
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .padding()
            .background(Color.gray)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // add item
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
    }
}

//#Preview {
//    ItemFormView(dismiss: DismissAction(), image: UIImage())
//}
