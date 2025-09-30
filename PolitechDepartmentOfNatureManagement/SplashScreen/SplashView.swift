//
//  SplashView.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 30.09.2025.
//

import SwiftUI

struct SplashView: View {
    @State private var topScale = 0.8
    @State private var topOpacity = 0.5

    @State private var bottomScale = 0.8
    @State private var bottomOpacity = 0.5

    var body: some View {
        ZStack {
            // Фон
            Image("BackgroundNature")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            // Верхний логотип
            VStack {
                Image("LdtImage")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .scaleEffect(topScale)
                    .opacity(topOpacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            topScale = 1.0
                            topOpacity = 1.0
                        }
                    }
                Spacer()
            }

            // Нижние логотипы
            VStack {
                Spacer()
                HStack(spacing: 5) {
                    Image("DEIDCMLogoImage")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)

                    Image("MikLogoImage")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)

                    Image("MmpLogoImage")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                }
                .scaleEffect(bottomScale)
                .opacity(bottomOpacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2).delay(0.3)) {
                        bottomScale = 1.0
                        bottomOpacity = 1.0
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    SplashView()
}
