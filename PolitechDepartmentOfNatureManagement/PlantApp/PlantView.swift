//
//  PlantView.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 09.09.2025.
//

import SwiftUI

struct PlantView: View {
    @StateObject private var viewModel = PlantViewModel()
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack(spacing: 20) {
            Text("Определение состояния растения")
                .font(.title2)
                .bold()

            if let selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                    .cornerRadius(12)
            }

            // Состояние анализа
            switch viewModel.state {
            case .default:
                Text("Выберите фото растения для анализа")
                    .foregroundColor(.gray)
            case .loading:
                ProgressView("Анализ...")
            case .success:
                if let result = viewModel.result {
                    VStack(spacing: 8) {
                        Text("Статус: \(result.status)")
                            .font(.headline)
                        Text(result.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            case .failure:
                Text(viewModel.errorMessage ?? "Ошибка")
                    .foregroundColor(.red)
            }

            VStack(spacing: 12) {
                CameraButton { img in
                    selectedImage = img
                    Task { await viewModel.analyze(image: img) }
                }
                GalleryPickerButton { img in
                    selectedImage = img
                    Task { await viewModel.analyze(image: img) }
                }
            }
            .padding(.top, 8)
        }
        .padding()
    }
}

#Preview {
    let vm = PlantViewModel()
    vm.state = .success
    vm.result = PlantAnalysisResponse(
        status: "Здоровое",
        description: "Листья ярко-зелёные, признаков болезни нет."
    )

    return PlantView()
        .environmentObject(vm)
}


#Preview {
    let vm = PlantViewModel()
    vm.state = .success
    vm.result = PlantAnalysisResponse(
        status: "Здоровое",
        description: "Листья ярко-зелёные, признаков болезни нет."
    )

    return PlantView()
        .environmentObject(vm)
}
