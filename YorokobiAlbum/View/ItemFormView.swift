//
//  ItemFormView.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/09.
//

import SwiftUI

struct ItemFormView: View {
    private let dismiss: DismissAction

    private let maxTitleLength = 30
    @State private var showWarningText = false
    @FocusState private var textFieldIsFocused: Bool

    private let image: UIImage
    @State private var title: String = ""

    init(dismiss: DismissAction, image: UIImage) {
        self.dismiss = dismiss
        self.image = image
    }

    var body: some View {
        VStack(spacing: textFieldIsFocused ? 24 : 96) {
            VStack(spacing: 16) {
                Image(uiImage: image)
                    .resizable()
                    .frame(minWidth: 100)
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .padding(.horizontal, 16)
                RateStars(3, type: .large)
            }
            VStack(spacing: 4) {
                TextField("タイトル", text: $title, axis: .vertical)
                    .focused($textFieldIsFocused)
                    .font(.system(size: 18))
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .padding(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                    )
                    .onChange(of: title) { _, text in
                        if text.contains("\n") {
                            title.removeAll { c in
                                c == "\n"
                            }
                        }
                        withAnimation {
                            showWarningText = text.count > maxTitleLength
                        }
                    }
                Text("30文字以内で入力してください")
                    .font(.caption)
                    .foregroundStyle(Color.red)
                    .opacity(showWarningText ? 1 : 0)
            }
            Spacer()
        }
        .padding(.top, 16)
        .padding(.horizontal, 24)
        .background(Color.white)
        .animation(.easeInOut, value: textFieldIsFocused)
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
//    ItemFormView(dismiss: nil, image: UIImage.sample10Square)
//}
