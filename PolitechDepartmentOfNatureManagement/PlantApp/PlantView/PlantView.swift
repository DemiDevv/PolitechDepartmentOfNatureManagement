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
    @State private var lastImageData: Data?

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
                                lastImageData = data
                                path.append(PlantRoute.review(imageData: data))
                            }
                        }
                        GalleryPickerButton { img in
                            if let data = img.jpegData(compressionQuality: 0.9) {
                                lastImageData = data
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
                        if let serverImage = response.imageData {
                            lastImageData = serverImage
                        } else {
                            lastImageData = imageData
                        }

                        let metadata = PlantAnalysisResponseMetadata(
                            treeSpecies: response.treeSpecies,
                            trunkRot: response.trunkRot,
                            hollow: response.hollow,
                            trunkCrack: response.trunkCrack,
                            trunkDamage: response.trunkDamage,
                            crownDamage: response.crownDamage,
                            fruitingBodies: response.fruitingBodies,
                            driedBranchesPercent: response.driedBranchesPercent,
                            other: response.other
                        )
                        path.append(PlantRoute.results(summary: metadata, imageData: response.imageData))
                    }

                case .results(let summary, let imageData):
                    ResultsAnalyzeView(
                        summary: summary,
                        imageData: imageData,
                        path: $path
                    )
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
