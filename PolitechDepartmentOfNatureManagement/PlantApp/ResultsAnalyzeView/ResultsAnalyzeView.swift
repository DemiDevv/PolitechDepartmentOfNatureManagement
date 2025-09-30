//
//  ResultsAnalyzeView.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 20.09.2025.
//

import SwiftUI

struct ResultsAnalyzeView: View {
    let summary: PlantAnalysisResponseMetadata
    let imageData: Data?
    @Binding var path: NavigationPath

    var body: some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    Text("Результаты анализа")
                        .font(.title2).bold()
                        .foregroundStyle(.white)

                    if let data = imageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    } else {
                        Color.gray.frame(height: 250)
                    }

                    ResultsAnalyzeTableView(summary: summary)

                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    path = NavigationPath()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()

    return NavigationStack(path: $path) {
        ResultsAnalyzeView(
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
            ),
            imageData: UIImage(systemName: "leaf")?.pngData(),
            path: $path
        )
    }
    .appBackground()
}
