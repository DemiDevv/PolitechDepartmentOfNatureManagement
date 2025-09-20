//
//  AppBackground.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 20.09.2025.
//

import SwiftUI

public struct AppBackground: ViewModifier {
    public func body(content: Content) -> some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()
            content
        }
    }
}
