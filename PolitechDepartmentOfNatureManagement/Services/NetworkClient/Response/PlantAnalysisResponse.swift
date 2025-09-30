//
//  PlantAnalysisResponse.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 24.09.2025.
//

import Foundation

// Полная модель с картинкой
struct PlantAnalysisResponse: Hashable {
    let treeSpecies: String
    let trunkRot: String
    let hollow: String
    let trunkCrack: String
    let trunkDamage: String
    let crownDamage: String
    let fruitingBodies: String
    let driedBranchesPercent: Int
    let other: String
    let imageData: Data?
}

// Легковесная модель без картинки для NavigationPath
struct PlantAnalysisResponseMetadata: Hashable {
    let treeSpecies: String
    let trunkRot: String
    let hollow: String
    let trunkCrack: String
    let trunkDamage: String
    let crownDamage: String
    let fruitingBodies: String
    let driedBranchesPercent: Int
    let other: String
}

extension AnalyzeTreeResponseDTO {
    func toPlantAnalysisResponse() -> PlantAnalysisResponse {
        guard let firstResult = results.first else {
            return PlantAnalysisResponse(
                treeSpecies: "Неизвестно",
                trunkRot: "—",
                hollow: "—",
                trunkCrack: "—",
                trunkDamage: "—",
                crownDamage: "—",
                fruitingBodies: "—",
                driedBranchesPercent: 0,
                other: "Нет данных анализа",
                imageData: nil
            )
        }

        let decodedImageData = Data(base64Encoded: processed_image, options: .ignoreUnknownCharacters)

        return PlantAnalysisResponse(
            treeSpecies: firstResult.characteristics.species,
            trunkRot: firstResult.characteristics.trunk_rot,
            hollow: firstResult.characteristics.hollow,
            trunkCrack: firstResult.characteristics.trunk_crack,
            trunkDamage: firstResult.characteristics.trunk_damage,
            crownDamage: firstResult.characteristics.crown_damage,
            fruitingBodies: firstResult.characteristics.fruiting_bodies,
            driedBranchesPercent: firstResult.characteristics.dried_branches_percent,
            other: firstResult.characteristics.other_characteristics,
            imageData: decodedImageData
        )
    }
}
