//
//  PlantRequest.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 09.09.2025.
//

import Foundation

struct PlantRequest: NetworkRequest {
    var rawBody: Data?

    var endpoint: URL? {
        // пока что моковый эндпоинт
        URL(string: "\(RequestConstants.baseURL)/api/v1/analyze")
    }

    var httpMethod: HttpMethod { .post }

    init(imageData: Data) {
        self.rawBody = imageData
    }
}

struct PlantAnalysisResponse: Decodable {
    let status: String
    let description: String
}

