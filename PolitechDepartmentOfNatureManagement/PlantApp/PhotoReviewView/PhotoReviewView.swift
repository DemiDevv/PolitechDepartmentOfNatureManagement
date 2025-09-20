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

    @State private var isLoading = false

    private var image: UIImage {
        UIImage(data: imageData) ?? UIImage()
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
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Button {
                    simulateAnalysisAndOpenResults()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "paperplane.fill").imageScale(.large)
                        Text("Отправить на анализ").font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryActionButtonStyle())
                .disabled(isLoading)
                .padding(.top, 8)
            }
            .padding(20)

            if isLoading {
                Color.black.opacity(0.25).ignoresSafeArea()
                ProgressView("Анализ…")
                    .padding(16)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func simulateAnalysisAndOpenResults() {
        isLoading = true
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 800_000_000)
            isLoading = false

            let mock = PlantAnalysisResponse(
                status: "Здоровое",
                description: "Листья ярко-зелёные, признаков болезни не выявлено."
            )
            onFinished(mock)
        }
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

