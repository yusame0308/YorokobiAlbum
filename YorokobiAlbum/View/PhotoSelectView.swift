//
//  PhotoSelectView.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/07.
//

import SwiftUI
import PhotosUI

struct PhotoSelectView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var path = [UIImage]()

    var body: some View {
        NavigationStack(path: $path) {
            PhotosPicker (
                "photosPicker",
                selection: $selectedPhotoItem,
                matching: .images,
                photoLibrary: .shared()
            )
            .photosPickerStyle(.inline)
            .photosPickerAccessoryVisibility(.hidden, edges: .vertical)
            .ignoresSafeArea(edges: [.bottom])
            .onChange(of: selectedPhotoItem) { _, item in
                Task {
                    guard let imageData = try await item?.loadTransferable(type: Data.self),
                          let uiImage = UIImage(data: imageData) else {
                        // error alert
                        dismiss()
                        return
                    }
                    path.append(uiImage)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            }
            .navigationDestination(for: UIImage.self) { image in
                ItemFormView(dismiss: dismiss, image: image)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    PhotoSelectView()
}
