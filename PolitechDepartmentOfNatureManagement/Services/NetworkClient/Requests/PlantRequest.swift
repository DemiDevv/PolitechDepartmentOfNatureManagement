//
//  PlantRequest.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 09.09.2025.
//

import Foundation

struct AnalyzeTreeRequest: NetworkRequest {
    let dto: Encodable?
    var rawBody: Data? { nil } // важно, чтобы использовался JSON

    init(imageData: String) {
        self.dto = AnalyzeTreeRequestDTO(image_data: imageData)
    }

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/analyze")
    }

    var httpMethod: HttpMethod { .post }
}
