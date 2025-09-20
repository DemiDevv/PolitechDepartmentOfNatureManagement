//
//  PlantView.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 09.09.2025.
//

import SwiftUI
import PhotosUI

struct PlantView: View {
    @StateObject private var viewModel = PlantViewModel()
    @State private var selectedItem: PhotosPickerItem?
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

            PhotosPicker("Выбрать фото", selection: $selectedItem, matching: .images)
                .buttonStyle(.borderedProminent)
                .padding(.top, 20)
        }
        .padding()
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    await viewModel.analyze(image: uiImage)
                }
            }
        }
    }
}

#Preview {
    // Мокаем ViewModel с тестовыми данными
    let vm = PlantViewModel()
    vm.state = .success
    vm.result = PlantAnalysisResponse(
        status: "Здоровое",
        description: "Листья ярко-зелёные, признаков болезни нет."
    )

    return PlantView()
        .environmentObject(vm) // если захочешь использовать через env
}
