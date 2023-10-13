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
    @State private var titleIsTooLong = false
    @FocusState private var textFieldIsFocused: Bool

    private let image: UIImage
    @State private var rate = 3
    @State private var title: String = ""

    init(dismiss: DismissAction, image: UIImage) {
        self.dismiss = dismiss
        self.image = image
    }

    var body: some View {
        VStack(spacing: textFieldIsFocused ? 0 : 36) {
            VStack(spacing: 0) {
                Image(uiImage: image)
                    .resizable()
                    .frame(minWidth: 150, minHeight: 150)
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                SelectableRateStars($rate, contentInset: .init(top: 12, leading: 48, bottom: 32, trailing: 48))
            }
            .padding(.horizontal, 32)
            VStack(spacing: 4) {
                TextField("タイトル", text: $title, axis: .vertical)
                    .focused($textFieldIsFocused)
                    .font(.system(size: 18))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
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
                            titleIsTooLong = text.count > maxTitleLength
                        }
                    }
                Text("30文字以内で入力してください")
                    .font(.caption)
                    .foregroundStyle(Color.red)
                    .opacity(titleIsTooLong ? 1 : 0)
            }
            Spacer(minLength: 4)
        }
        .padding(.top, textFieldIsFocused ? 0 : 16)
        .padding(.horizontal, 24)
        .background(Color.white)
        .interactiveDismissDisabled(true)
        .animation(.easeOut, value: textFieldIsFocused)
        .onAppear {
            textFieldIsFocused = true
        }
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
                .disabled(titleIsTooLong || title.isEmpty)
            }
        }
    }
}

//#Preview {
//    ItemFormView(dismiss: nil, image: UIImage.sample10Square)
//}
