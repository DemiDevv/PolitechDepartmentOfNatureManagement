//
//  AnalyzeTreeResponseDTO.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 24.09.2025.
//

import Foundation

struct AnalyzeTreeResponseDTO: Decodable {
    let results: [TreeResult]
    let processed_image: String
    let processing_time: Double
}

struct TreeResult: Decodable {
    let tree_id: Int
    let characteristics: TreeCharacteristics
}

struct TreeCharacteristics: Decodable {
    let species: String
    let trunk_rot: String
    let hollow: String
    let trunk_crack: String
    let trunk_damage: String
    let crown_damage: String
    let fruiting_bodies: String
    let dried_branches_percent: Int
    let other_characteristics: String
}
