//
//  ResultsAnalyzeTableView.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 27.09.2025.
//

import SwiftUI

struct ResultsAnalyzeTableView: View {
    let summary: PlantAnalysisResponseMetadata

    var body: some View {
        VStack(spacing: 10) {
            // Секция 1 — Тип дерева
            sectionCard {
                HStack {
                    Text("Тип дерева:")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Spacer()
                    Text(summary.treeSpecies)
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }

            // Секция 2 — Сетка характеристик
            sectionCard {
                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 16
                ) {
                    infoRow("Гнилость ствола", summary.trunkRot)
                    infoRow("Дупло", summary.hollow)
                    infoRow("Трещины", summary.trunkCrack)
                    infoRow("Повреждения ствола", summary.trunkDamage)
                    infoRow("Повреждения кроны", summary.crownDamage)
                    infoRow("Плодовые тела", summary.fruitingBodies)
                    infoRow("Сухие ветви", "\(summary.driedBranchesPercent)%")
                }
            }

            // Секция 3 — Прочее
            if !summary.other.isEmpty {
                sectionCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Прочее")
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(summary.other)
                            .foregroundStyle(.white.opacity(0.9))
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }

    // MARK: - Helpers
    private func sectionCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private func infoRow(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
            Text(value)
                .font(.headline)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ResultsAnalyzeTableView(
        summary: PlantAnalysisResponseMetadata(
            treeSpecies: "Дуб",
            trunkRot: "Нет",
            hollow: "Нет",
            trunkCrack: "Незначительные",
            trunkDamage: "Нет",
            crownDamage: "Нет",
            fruitingBodies: "Не обнаружено",
            driedBranchesPercent: 5,
            other: "Листья ярко-зелёные, признаков болезни нет."
        )
    )
    .padding()
    .background(.black)
}
