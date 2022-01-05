//
//  UIViewExt.swift.swift
//  Movie List
//
//  Created by Zain Haider on 05/01/2022.
//

import UIKit

extension UIView {
    /// Add both shadow and corner radius.
    /// - Parameters:
    ///   - capacity: capacity of shadow.
    ///   - cornerRadius: Corner radius of shadow.
    func AddShadowAndCornerRadius(capacity: Float = 0.4, cornerRadius: CGFloat = 12, shadowColor: UIColor = .gray) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: -2, height: 7)
        self.layer.backgroundColor = self.backgroundColor?.cgColor ?? UIColor.white.cgColor
        self.layer.shadowOpacity = capacity
        self.layer.shadowRadius = cornerRadius
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}

