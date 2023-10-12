//
//  ImageCropView.swift
//  YorokobiAlbum
//
//  Created by 小原宙 on 2023/10/11.
//

import SwiftUI

struct ImageCropView: View {
   private enum Direction {
        case portrait
        case landscape

        var isPortrait: Bool {
            self == .portrait
        }
    }

    @Binding private var path: [AddItemViewType]

    private let dismiss: DismissAction
    private let image: UIImage
    private let direction: Direction
    private let padding = 24.0

    @State private var currentPoint = CGPoint(x: 0.0, y: 0.0)
    @State private var initialPosition = 0.0
    @State private var upperLimit = 0.0
    @State private var lowerLimit = 0.0
    @State private var imageSize = CGSize(width: 0.0, height: 0.0)
    @State private var isFirstSetup = true

    init(dismiss: DismissAction, image: UIImage, path: Binding<[AddItemViewType]>) {
        self.dismiss = dismiss
        self.image = image
        direction = image.ratio > 1 ? .landscape : .portrait
        self._path = path
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: imageSize.width, height: imageSize.height)
                    .border(Color.black.opacity(0.3), width: 1)
                    .position(currentPoint)
                    .overlay {
                        Color.white
                            .opacity(0.5)
                            .overlay {
                                Rectangle()
                                    .aspectRatio(1, contentMode: .fit)
                                    .padding(padding)
                                    .position(x: geometry.size.width/2, y: geometry.size.height/2)
                                    .blendMode(.destinationOut)
                            }
                            .compositingGroup()
                    }
                    .clipped()
                    .ignoresSafeArea(edges: .bottom)
                Color.clear
                    .aspectRatio(1, contentMode: .fit)
                    .border(Color.black.opacity(0.5), width: 2)
                    .padding(padding)
            }
            .background(Color.white)
            .gesture(dragGesture)
            .onChange(of: geometry.size) { _, viewSize in
                setup(viewSize: viewSize)
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
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    path.append(.itemForm(image: image))
                }, label: {
                    Image(systemName: "arrow.forward.circle.fill")
                })
            }
        }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let translationLength = direction.isPortrait ? value.translation.height : value.translation.width
                let nextPosition = initialPosition + translationLength
                let position = nextPosition > upperLimit ? upperLimit : nextPosition < lowerLimit ? lowerLimit : nextPosition

                if direction.isPortrait {
                    currentPoint.y = position
                } else {
                    currentPoint.x = position
                }
            }
            .onEnded { value in
                initialPosition = direction.isPortrait ? currentPoint.y : currentPoint.x
            }
    }

    private func setup(viewSize: CGSize) {
        guard isFirstSetup else { return }

        let borderLength = viewSize.width - padding * 2
        let imageLength = direction.isPortrait
        ? borderLength / image.ratio
        : borderLength * image.ratio
        let centerPoint = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        let centerValue = direction.isPortrait ? centerPoint.y : centerPoint.x
        upperLimit = centerValue - borderLength/2 + imageLength/2
        lowerLimit = centerValue + borderLength/2 - imageLength/2
        currentPoint = centerPoint
        initialPosition = centerValue
        imageSize = direction.isPortrait ? CGSize(width: borderLength, height: imageLength) : CGSize(width: imageLength, height: borderLength)

        isFirstSetup = false
    }
}

//#Preview {
//    ImageCropView(dismiss: nil, image: UIImage.sample1)
//}
