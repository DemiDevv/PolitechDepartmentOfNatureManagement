//
//  ResultsPlaceholderView.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 20.09.2025.
//

import SwiftUI

struct ResultsPlaceholderView: View {
    let summary: ResultSummary

    var body: some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()
            VStack(spacing: 16) {
                Text("Результаты анализа")
                    .font(.title2).bold()
                    .foregroundStyle(.white)

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Тип дерева:")
                            .font(.headline).foregroundStyle(.white)
                        Spacer()
                        Text(summary.treeSpecies)
                            .font(.headline).foregroundStyle(.white)
                    }
                    Divider().background(.white.opacity(0.3))
                    Text(summary.description)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .padding(16)
                .background(Color.white.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.top, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ResultsPlaceholderView(
            summary: ResultSummary(treeSpecies: "Дуб", description: "Листья ярко-зелёные, признаков болезни нет.")
        )
    }
    .appBackground()
}
