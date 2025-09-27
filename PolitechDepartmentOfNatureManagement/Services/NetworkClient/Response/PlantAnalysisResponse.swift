//
//  PlantAnalysisResponse.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 24.09.2025.
//

import Foundation

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
}

extension AnalyzeTreeResponseDTO {
    func toPlantAnalysisResponse() -> PlantAnalysisResponse {
        if let first = results.first {
            let c = first.characteristics
            return PlantAnalysisResponse(
                treeSpecies: c.species,
                trunkRot: c.trunk_rot,
                hollow: c.hollow,
                trunkCrack: c.trunk_crack,
                trunkDamage: c.trunk_damage,
                crownDamage: c.crown_damage,
                fruitingBodies: c.fruiting_bodies,
                driedBranchesPercent: c.dried_branches_percent,
                other: c.other_characteristics
            )
        } else {
            return PlantAnalysisResponse(
                treeSpecies: "Неизвестно",
                trunkRot: "-",
                hollow: "-",
                trunkCrack: "-",
                trunkDamage: "-",
                crownDamage: "-",
                fruitingBodies: "-",
                driedBranchesPercent: 0,
                other: "Нет данных анализа"
            )
        }
    }
}

