//
//  PhotoReviewView.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 20.09.2025.
//

import SwiftUI

struct PhotoReviewView: View {
    public let imageData: Data
    public var onFinished: (PlantAnalysisResponse) -> Void

    @StateObject private var viewModel = PhotoReviewViewModel()

    private var image: UIImage {
        (UIImage(data: imageData)?.normalized()) ?? UIImage()
    }

    public init(
        imageData: Data,
        onFinished: @escaping (PlantAnalysisResponse) -> Void
    ) {
        self.imageData = imageData
        self.onFinished = onFinished
    }

    public var body: some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()

            VStack(spacing: 16) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.75)
                    .cornerRadius(16)

                Button {
                    viewModel.analyze(image: image)
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "paperplane.fill").imageScale(.large)
                        Text("Отправить на анализ").font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryActionButtonStyle())
                .disabled(viewModel.state == .loading)
                .padding(.top, 8)
            }
            .padding(20)

            if viewModel.state == .loading {
                Color.black.opacity(0.25).ignoresSafeArea()
                ProgressView("Анализ…")
                    .padding(16)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
        .onChange(of: viewModel.state) { newState in
            if newState == .success, let result = viewModel.result {
                onFinished(result)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PhotoReviewView(
            imageData: (UIImage(systemName: "leaf") ?? UIImage()).pngData() ?? Data()
        ) { _ in }
    }
    .appBackground()
}

