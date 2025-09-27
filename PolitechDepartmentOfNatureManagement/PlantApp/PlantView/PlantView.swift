//
//  PlantView.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 09.09.2025.
//

import SwiftUI

struct PlantView: View {
    @State private var path: NavigationPath = NavigationPath()
    @State private var analysisSessionId = UUID()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color("violetNature"), location: 0.0),
                        .init(color: Color("violetNature"), location: 0.2),
                        .init(color: Color("purpleNature"), location: 1.0)
                    ]),
                    startPoint: .bottomTrailing,
                    endPoint: .topLeading
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Анализ растения")
                        .font(.title).bold()
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
                    .id(analysisSessionId)
                    .padding(.top, 8)
                }
                .padding()
            }
            .navigationDestination(for: PlantRoute.self) { route in
                switch route {
                case .review(let imageData):
                    PhotoReviewView(imageData: imageData) { response in
                        let summary = ResultSummary(
                            treeSpecies: response.treeSpecies,
                            description: response.description
                        )
                        path.append(PlantRoute.results(summary: summary))
                    }

                case .results(let summary):
                    ResultsAnalyzeView(summary: summary, path: $path)
                        .onDisappear {
                            if path.isEmpty {
                                analysisSessionId = UUID()
                            }
                        }
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
