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
    @State private var path = [AddItemViewType]()
    @State private var showingErrorAlert = false

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
                        showingErrorAlert = true
                        return
                    }
                    path.append(.imageCrop(image: uiImage))
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
            .alert("エラーが発生しました", isPresented: $showingErrorAlert, actions: {
                Button("OK") {
                    dismiss()
                }
            }, message: {
                Text("もう一度やり直してください")
            })
            .navigationDestination(for: AddItemViewType.self) { viewType in
                switch viewType {
                case .imageCrop(let image):
                    ImageCropView(dismiss: dismiss, image: image, path: $path)
                        .navigationBarBackButtonHidden(true)
                case .itemForm(let image):
                    ItemFormView(dismiss: dismiss, image: image)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    PhotoSelectView()
}
