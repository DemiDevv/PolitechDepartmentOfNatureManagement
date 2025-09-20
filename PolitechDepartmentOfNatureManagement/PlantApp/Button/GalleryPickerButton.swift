//
//  GalleryPickerButton.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 20.09.2025.
//

import SwiftUI
import PhotosUI

public struct GalleryPickerButton: View {
    @State private var item: PhotosPickerItem?
    public var title: String
    public var icon: String
    public var onImage: (UIImage) -> Void

    public init(
        title: String = "Выбрать из галереи",
        icon: String = "photo.on.rectangle",
        onImage: @escaping (UIImage) -> Void
    ) {
        self.title = title
        self.icon = icon
        self.onImage = onImage
    }

    public var body: some View {
        PhotosPicker(
            selection: $item,
            matching: .images,
            photoLibrary: .shared()
        ) {
            HStack(spacing: 10) {
                Image(systemName: icon).imageScale(.large)
                Text(title)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(GhostButtonStyle())
        .onChange(of: item) { newItem in
            Task {
                guard
                    let newItem,
                    let data = try? await newItem.loadTransferable(type: Data.self),
                    let ui = UIImage(data: data)
                else { return }
                onImage(ui)
            }
        }
        .accessibilityLabel(title)
    }
}
