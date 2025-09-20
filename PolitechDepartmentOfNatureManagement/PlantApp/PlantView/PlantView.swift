//
//  PlantView.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 09.09.2025.
//

import SwiftUI

struct PlantView: View {
    @State private var path: NavigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                AppTheme.bg.ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("") // отступ по макету
                        .font(.title2).bold()
                        .foregroundColor(.white)

                    Text("Выберите фото растения для анализа")
                        .font(.title3).bold()
                        .foregroundColor(.white)

                    VStack(spacing: 12) {
                        CameraButton { img in
                            if let data = img.jpegData(compressionQuality: 0.9) {
                                path.append(PlantRoute.review(imageData: data))
                            }
                        }
                        GalleryPickerButton { img in
                            if let data = img.jpegData(compressionQuality: 0.9) {
                                path.append(PlantRoute.review(imageData: data))
                            }
                        }
                    }
                    .padding(.top, 8)
                }
                .padding()
            }
            .navigationDestination(for: PlantRoute.self) { route in
                switch route {
                case .review(let imageData):
                    PhotoReviewView(imageData: imageData) { response in
                        // по завершении анализа — пушим экран результатов
                        let summary = ResultSummary(status: response.status,
                                                    description: response.description)
                        path.append(PlantRoute.results(summary: summary))
                    }

                case .results(let summary):
                    ResultsPlaceholderView(summary: summary)
                }
            }
        }
        .appBackground()
    }
}

#Preview {
    NavigationStack {
        PlantView()
    }
    .appBackground()
}
