//
//  PlantViewModel.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 09.09.2025.
//

import Foundation
import SwiftUI

@MainActor
final class PlantViewModel: ObservableObject {
    @Published var state: LoadingState = .default
    @Published var result: PlantAnalysisResponse?
    @Published var errorMessage: String?

    private let service: PlantService

    init(service: PlantService = .shared) {
        self.service = service
    }

    func analyze(image: UIImage) async {
        state = .loading
        do {
            guard let imageData = image.jpegData(compressionQuality: 0.7) else {
                throw NetworkClientError.incorrectRequest("Невозможно преобразовать фото")
            }
            let response = try await service.analyzePlant(imageData: imageData)
            self.result = response
            state = .success
        } catch {
            state = .failure
            errorMessage = error.localizedDescription
        }
    }
}
