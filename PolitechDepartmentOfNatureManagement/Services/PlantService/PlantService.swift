//
//  PlantService.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 09.09.2025.
//

import Foundation

final class PlantService {
    static let shared = PlantService()
    private let client: NetworkClient

    private init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }

    func analyzePlant(imageData: Data) async throws -> PlantAnalysisResponse {
        // пока что можно просто вернуть мок
        // return PlantAnalysisResponse(status: "Здоровое", description: "Листья зелёные, повреждений нет.")

        try await client.send(request: PlantRequest(imageData: imageData))
    }
}
