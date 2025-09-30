//
//  UIImage+Extension.swift
//  PolitechDepartmentOfNatureManagement
//
//  Created by Demain Petropavlov on 30.09.2025.
//

import UIKit

extension UIImage {
    func normalized() -> UIImage {
        if imageOrientation == .up {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage ?? self
    }
}
