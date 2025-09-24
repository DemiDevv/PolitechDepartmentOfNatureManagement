//
//  PlantAnalysisResponse.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 24.09.2025.
//

import Foundation

struct PlantAnalysisResponse: Hashable {
    let status: String
    let description: String
}

extension AnalyzeTreeResponseDTO {
    func toPlantAnalysisResponse() -> PlantAnalysisResponse {
        // Берём первую запись из results (если их несколько)
        if let first = results.first {
            return PlantAnalysisResponse(
                status: first.characteristics.species,
                description: """
                Гнилость ствола: \(first.characteristics.trunk_rot)
                Дупло: \(first.characteristics.hollow)
                Трещины: \(first.characteristics.trunk_crack)
                Повреждения ствола: \(first.characteristics.trunk_damage)
                Повреждения кроны: \(first.characteristics.crown_damage)
                Плодовые тела: \(first.characteristics.fruiting_bodies)
                Сухие ветви: \(first.characteristics.dried_branches_percent)%
                Прочее: \(first.characteristics.other_characteristics)
                """
            )
        } else {
            return PlantAnalysisResponse(
                status: "Неизвестно",
                description: "Нет данных анализа"
            )
        }
    }
}
