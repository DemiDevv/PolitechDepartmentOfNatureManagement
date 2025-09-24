//
//  PlantService.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 09.09.2025.
//

import Foundation

final class TreeAnalysisService {
    static let shared = TreeAnalysisService()
    private let client: NetworkClient

    private init(client: NetworkClient = DefaultNetworkClient.shared) {
        self.client = client
    }

    func analyzeTree(imageData: String) async throws -> AnalyzeTreeResponseDTO {
        try await client.send(request: AnalyzeTreeRequest(imageData: imageData))
    }
}

