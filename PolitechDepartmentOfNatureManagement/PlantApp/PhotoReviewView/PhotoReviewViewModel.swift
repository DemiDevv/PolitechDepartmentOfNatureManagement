//
//  PhotoReviewViewModel.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 20.09.2025.
//

import SwiftUI

@MainActor
final class PhotoReviewViewModel: ObservableObject {
    @Published var state: LoadingState = .default
    @Published var result: PlantAnalysisResponse?
    @Published var errorMessage: String?

    private let service: PlantService
    private var analyzeTask: Task<Void, Never>?

    init(service: PlantService = .shared) {
        self.service = service
    }

    func analyze(image: UIImage) {
        analyzeTask?.cancel()
        state = .loading
        errorMessage = nil
        result = nil

        analyzeTask = Task { [weak self] in
            guard let self else { return }
            do {
                guard let data = image.jpegData(compressionQuality: 0.7) else {
                    throw NetworkClientError.incorrectRequest("Невозможно преобразовать фото")
                }

                let response = try await service.analyzePlant(imageData: data)

                if let imageData = response.imageData {
                    print("✅ Пришло изображение, размер в байтах:", imageData.count)
                } else {
                    print("⚠️ Изображение не пришло или Base64 пустой")
                }
                try Task.checkCancellation()

                self.result = response
                self.state = .success

            } catch is CancellationError {
                // Пользователь закрыл экран — ничего не делаем
            } catch {
                self.state = .failure
                self.errorMessage = error.localizedDescription
                print("❌ Ошибка анализа:", error)
                dump(error)
            }
        }
    }

    deinit {
        analyzeTask?.cancel()
    }
}
