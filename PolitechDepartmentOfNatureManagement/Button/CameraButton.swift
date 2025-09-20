//
//  CameraButton.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 20.09.2025.
//

import SwiftUI

public struct CameraButton: View {
    @State private var showCamera = false
    public var title: String
    public var icon: String
    public var onImage: (UIImage) -> Void

    public init(
        title: String = "Снять на камеру",
        icon: String = "camera",
        onImage: @escaping (UIImage) -> Void
    ) {
        self.title = title
        self.icon = icon
        self.onImage = onImage
    }

    public var body: some View {
        Button {
            showCamera = true
        } label: {
            HStack(spacing: 10) {
                Image(systemName: icon).imageScale(.large)
                Text(title)
            }
        }
        .buttonStyle(PrimaryActionButtonStyle())
        .sheet(isPresented: $showCamera) {
            CameraPicker { img in onImage(img) }
                .ignoresSafeArea()
        }
        .accessibilityLabel(title)
    }
}
