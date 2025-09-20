//
//  PlantRoute.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 20.09.2025.
//

import SwiftUI

enum PlantRoute: Hashable {
    case review(imageData: Data)
    case results(summary: ResultSummary)
}

struct ResultSummary: Hashable {
    let status: String
    let description: String
}
