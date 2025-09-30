//
//  SplashView.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 30.09.2025.
//

import SwiftUI

struct SplashView: View {
    @State private var scale = 0.8
    @State private var opacity = 0.5

    var body: some View {
        ZStack {
            // Фон
            Image("BackgroundNature")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .blur(radius: 8)

            VStack {
                Spacer()

                // Логотипы организаций
                VStack(spacing: 20) {
                    Image("LdtImage")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)

                    Image("MikLogoImage")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)

                    Image("MmpLogoImage")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                }
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        scale = 1.0
                        opacity = 1.0
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    SplashView()
}
