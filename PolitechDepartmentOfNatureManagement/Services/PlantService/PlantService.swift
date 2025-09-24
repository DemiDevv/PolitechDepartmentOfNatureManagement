//
//  PlantService.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 24.09.2025.
//

import Foundation

final class PlantService {
    static let shared = PlantService()
    private let client: NetworkClient

    private init(client: NetworkClient = DefaultNetworkClient.shared) {
        self.client = client
    }

    func analyzePlant(imageData: Data) async throws -> PlantAnalysisResponse {
        let base64String = imageData.base64EncodedString()
        let dto: AnalyzeTreeResponseDTO = try await client.send(
            request: AnalyzeTreeRequest(imageData: base64String)
        )
        return dto.toPlantAnalysisResponse()
    }
}
